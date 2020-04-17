void mouseReleased() {
  for (inputField t : inputs) {
    t.selected = false;
  }
  for (inputField t : inputs) {
    if (t.mouseOver()) {
      t.selected = true; 
      break;
    }
  }
  if(submit.mouseOver()){
    boolean bad = false;
    for(inputField t : inputs){
      if(t.text==""){ bad = true;}
    }
    if(!bad){
      TableRow newRow = table.addRow();
      newRow.setInt("id",table.lastRowIndex());
      newRow.setString("surname", inputs.get(0).text);
      newRow.setString("name", inputs.get(1).text);
      newRow.setString("midname", inputs.get(2).text);
      newRow.setString("birthdate", inputs.get(3).text);
      saveTable(table,"data/thing.csv");
    }
  }
}

void keyPressed() {
  if (key != ESC && keyCode != SHIFT && key != TAB && keyCode != CONTROL && keyCode != ALT) {
    for (inputField t : inputs) {
        t.listen(key);
    }
  }
}
