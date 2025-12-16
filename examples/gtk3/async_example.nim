# nim c async_example.nim
import nim2gtk/[gtk, gobject, glib]
import osproc

let command = "ping 8.8.8.8 -c 10"

proc onClickRun(b: Button) =
  echo "Clicked on test"

proc onClickAsync(b: Button) =
  if spawnCommandLineAsync(command):
    echo "Done"
    # Must use ChildWatch to get output
  else:
    echo "Failed"

proc onClickPing(b: Button) =
  echo execCmd(command)

proc createButtons(mainBox: Box) =
  let
    btnPing = newButton("Ping")
    btnAsyncPing = newButton("Async Ping")
    btnIsRunning = newButton("Click to test")
    testBox = newBox(Orientation.horizontal, 3)

  btnPing.connect("clicked", onClickPing)
  btnAsyncPing.connect("clicked", onClickAsync)
  btnIsRunning.connect("clicked", onClickRun)
  testBox.add(btnPing)
  testBox.add(btnAsyncPing)
  testBox.add(btnIsRunning)
  mainBox.add(testBox)

# Close program by clicking on title bar
proc onClickClose(w: Window) =
  echo "exiting..."
  mainQuit()

proc main() =
  gtk.init()

  let
    window = newWindow()
    mainBox = newBox(Orientation.vertical, 3)

  mainBox.createButtons()

  window.title = "Async Ping Test"
  window.setBorderWidth(4)
  window.add(mainBox)

  window.showAll()
  window.connect("destroy", onClickClose)
  gtk.main()

main()
