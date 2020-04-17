Table table;
button submit;
void setup() {
  size(600, 100);
  table = loadTable("thing.csv", "header");
  //table.addColumn("id");
  //table.addColumn("surname");
  //table.addColumn("name");
  //table.addColumn("midname");
  //table.addColumn("birthdate");
  
  //saveTable(table, "data/thing.csv");
  
  inputs.add(new inputField(95, 30, 190, 20));
  inputs.add(new inputField(295, 30, 190, 20));
  inputs.add(new inputField(495, 30, 190, 20));
  inputs.add(new inputField(95, 75, 190, 20));
  submit = new button("ПОДТВЕРДИТЬ", 395, 75, 190*2+10, 20);
  textSize(14);
}

void draw() {
  background(100);
  fill(255);
  textAlign(LEFT);
  text("Фамилия:", 0, 15);
  text("Имя:", 200, 15);
  text("Отчество:", 400, 15);
  text("Дата рождения(ДД.ММ.ГГ):", 0, 60);
  if (!inputs.isEmpty()) {
    for (inputField t : inputs) {
      t.show();
    }
  }
  submit.show();
}
