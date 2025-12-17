import nim2gtk/[gtk4, gdk4, glib, gobject, gio]

const menuData =
  """
  <interface>
    <menu id="menuModel">
      <section>
        <item>
          <attribute name="label">Normal Menu Item</attribute>
          <attribute name="action">win.normal-menu-item</attribute>
        </item>
        <submenu>
          <attribute name="label">Submenu</attribute>
          <item>
            <attribute name="label">Submenu Item</attribute>
            <attribute name="action">win.submenu-item</attribute>
          </item>
        </submenu>
        <item>
          <attribute name="label">Toggle Menu Item</attribute>
          <attribute name="action">win.toggle-menu-item</attribute>
        </item>
      </section>
      <section>
        <item>
          <attribute name="label">Radio 1</attribute>
          <attribute name="action">win.radio</attribute>
          <attribute name="target">1</attribute>
        </item>
        <item>
          <attribute name="label">Radio 2</attribute>
          <attribute name="action">win.radio</attribute>
          <attribute name="target">2</attribute>
        </item>
        <item>
          <attribute name="label">Radio 3</attribute>
          <attribute name="action">win.radio</attribute>
          <attribute name="target">3</attribute>
        </item>
      </section>
    </menu>
  </interface>"""

proc changeLabelButton(
    action: gio.SimpleAction, parameter: glib.Variant, label: Label
) =
  label.setLabel("Text set from button")

proc normalMenuItem(action: gio.SimpleAction, parameter: glib.Variant, label: Label) =
  label.setLabel("Text set from normal menu item")

proc toggleMenuItem(action: gio.SimpleAction, parameter: glib.Variant, label: Label) =
  let newState = newVariantBoolean(not action.getState.getBoolean)
  action.changeState(newState)
  label.setLabel(
    "Text set from toggle menu item. Toggle state: " & $newState.getBoolean
  )

proc submenuItem(action: gio.SimpleAction, parameter: glib.Variant, label: Label) =
  label.setlabel("Text set from submenu item")

proc radio(action: gio.SimpleAction, parameter: glib.Variant, label: Label) =
  var l: uint64
  let newState: glib.Variant = newVariantString(parameter.getString(l))
  action.changeState(parameter)
  let str: string = "From Radio menu item " & getString(newState, l)
  label.setLabel(str)

proc pressed(gesture: GestureClick, n_press: int, x, y: float, menu: PopOverMenu) =
  #We are placing our menu at the point where
  #the click happened, before popping it up.
  let r = gdk4.Rectangle(x: x.int32, y: y.int32, width: 1, height: 1)
  setPointingTo(cast[Popover](menu), r)
  popup(cast[Popover](menu))

var menu: PopOverMenu

proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    box = newBox(gtk4.Orientation.vertical, 12)
    button1 = newButton("Change Label Text")
    actionGroup: gio.SimpleActionGroup = newSimpleActionGroup()
    label: Label = newLabel("Initial Text")

  var action: SimpleAction
  action = newSimpleAction("change-label-button")
  discard action.connect("activate", changeLabelButton, label)
  actionGroup.addAction(action)

  action = newSimpleAction("normal-menu-item")
  discard action.connect("activate", normalMenuItem, label)
  actionGroup.addAction(action)

  var v = newVariantBoolean(true)
  action = newSimpleActionStateful("toggle-menu-item", nil, v)
  discard action.connect("activate", toggleMenuItem, label)
  actionGroup.addAction(action)

  action = newSimpleAction("submenu-item")
  discard action.connect("activate", submenuItem, label)
  actionGroup.addAction(action)

  v = newVariantString("1")
  let vt = newVariantType("s")
  action = newSimpleActionStateful("radio", vt, v)
  discard action.connect("activate", radio, label)
  actionGroup.addAction(action)
  window.insertActionGroup("win", actionGroup)

  label.setMarginTop(12)
  label.setMarginBottom(12)

  let press: GestureClick = newGestureClick()
  press.setButton(gdk4.BUTTON_PRIMARY)
  label.addController(press)
  box.append(label)

  var builder = newBuilderFromString(menuData)
  let menuModel = builder.getMenuModel("menuModel")
  menu = newPopoverMenu(menuModel)
  menu.setParent(label)
  press.connect("pressed", pressed, menu)

  button1.setHalign(gtk4.Align.center)
  button1.setActionName("win.change-label-button")
  box.append(button1)
  window.setChild(box)
  window.present

proc main() =
  let app = newApplication("org.gtk.example")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()
