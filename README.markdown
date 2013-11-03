
# Tip Calculator

An exercise in learning iOS development

## Layout

- a Single View
- TableView
- Header
- first n rows are for the bill amount
- n + 2 is for the tip percentage slider
  - might put this in the footer
- bill amount row has:
  - bill amount
  - tip amount
  - total
  - +/- to add or delete a row
- tip percentage row has:
  - tip slider (5 to 35)
  - label to show current tip percentage
  - 10,15,20 as preset buttons for slider

## To Do

### Doing

- when adding a row, split bill evenly among all new rows
- when deleting a row, split bill evenly among all remaining rows

### Do

- hide '-' button for first bill amount row
- put tipSlider in it's own section
- footer section shows total bill
- 'make it right'
  - bill amount for this cell = Total - (subtotal of all other rows)

### Done

- store bill amounts in an array
- trap slider event
- add tip percentage cell 
- add TableView
- use a TableViewController
- add a Header
- create cell and class for bill amount row
- display it


