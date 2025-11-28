# Simple calculator example
# nim c calculator.nim
import nim2gtk/[gtk, gobject, gio]
import std/strutils
import kexpr

# Global variable to store the current expression
var currentExpression: string = ""
var newExpression: bool = false

type Display = object
  entry: Entry
  input: string

# Update the display
proc updateDisplay(btn: Button, display: Display) =
  let operators = @['+', '-', '*', '/']

  if display.input != "":
    # Clear display if input is not operator
    if newExpression and not (display.input[0] in operators):
      currentExpression = ""
    # Append text to the current expression
    currentExpression.add(display.input)
  # Update display text
  display.entry.setText(currentExpression)
  newExpression = false

# Clear the display
proc clearDisplay(btn: Button, entry: Entry) =
  currentExpression = ""
  entry.setText(currentExpression)

# Delete last character
proc onDelete(btn: Button, entry: Entry) =
  if currentExpression == "":
    return
  currentExpression = currentExpression[0 .. ^2]
  entry.setText(currentExpression)

# Remove trailing zeros and decimal point
func stripFloat(f: float64): string =
  var s = $(f)
  while s.endsWith('0'):
    s.setLen(s.len - 1)
  if s.endsWith('.'):
    s.setLen(s.len - 1)

  result = s

# Calculate the result
proc calculateResult(btn: Button, entry: Entry) =
  if currentExpression == "":
    return
  # eval expression from kexpr
  let e = expression(currentExpression)

  if e.error() != 0:
    entry.setText("Error")
    currentExpression = ""
    return

  assert e.error() == 0

  let result = stripFloat(e.toFloat64)

  entry.setText(result)
  currentExpression = result
  newExpression = true

proc formatPercent(btn: Button, display: Display) =
  var newExp: string
  var num: string

  # Get last number
  let chars = {'+', '-', '*', '/'}
  let idx = currentExpression.rfind(chars)
  if idx != -1:
    # If character is found, slice the string
    # up to and including the character
    newExp = currentExpression[0 .. idx]
    num = currentExpression[idx + 1 .. ^1]
  else:
    # If character is not found, return original string
    num = currentExpression

  if num == "" or num == ".":
    return

  # Format as decimal
  num.add("/100")
  let e = expression(num)
  num = $e.toFloat64

  newExp.add(num)
  currentExpression = newExp
  updateDisplay(btn, display)

# The main application logic
proc appActivate(app: Application) =
  let window = newApplicationWindow(app)
  window.title = "Calculator"
  window.defaultSize = (220, 260)

  # Create main box to hold widgets
  let mainBox = newBox(Orientation.vertical, 0)
  window.add(mainBox)

  # Create another box to add padding
  let elementBox = newBox(Orientation.vertical, 0)
  mainBox.packStart(elementBox, false, false, 10)

  # Create an entry widget for display
  var display: Display
  display.entry = newEntry()
  display.entry.editable = false # Make it read-only
  display.entry.alignment = 1 # Set alignment from 0 (left) to 1 (right)
  display.entry.setMargin(10)
  elementBox.packStart(display.entry, false, false, 0)

  # Create a grid for calculator buttons
  let grid = newGrid()
  grid.rowSpacing = 4
  grid.columnSpacing = 4
  grid.setMargin(10)
  grid.halign = Align.center
  elementBox.packStart(grid, false, false, 0)

  # Define button labels and their positions (row, col)
  let buttons = [
    ("AC", 0, 0), ("<", 0, 1), ("%", 0, 2), ("/", 0, 3),
    ("7", 1, 0), ("8", 1, 1), ("9", 1, 2), ("x", 1, 3),
    ("4", 2, 0), ("5", 2, 1), ("6", 2, 2), ("-", 2, 3),
    ("1", 3, 0), ("2", 3, 1), ("3", 3, 2), ("+", 3, 3),
                              (".", 4, 2), ("=", 4, 3),
  ]

  for (label, row, col) in buttons:
    let button = newButton(label)
    display.input = label
    if label == "=":
      button.connect("clicked", calculateResult, display.entry)
    elif label == "AC":
      button.connect("clicked", clearDisplay, display.entry)
    elif label == "<":
      button.connect("clicked", onDelete, display.entry)
    elif label == "x":
      display.input = "*" # Has to be '*' char for parser to work
      button.connect("clicked", updateDisplay, display)
    elif label == "%":
      display.input = "" # Has to be '' char for parser to work
      button.connect("clicked", formatPercent, display)
    else:
      button.connect("clicked", updateDisplay, display)

    grid.attach(button, col, row, 1, 1)

  # Add separate buttons for better placement
  let zeroButton = newButton("0")
  display.input = "0"
  zeroButton.connect("clicked", updateDisplay, display)
  grid.attach(zeroButton, 0, 4, 2, 1)

  window.showAll()

proc main() =
  let app = newApplication("org.gtk.example.calculator")
  connect(app, "activate", appActivate)
  discard run(app)

when isMainModule:
  main()
