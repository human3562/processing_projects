void keyPressed() {
  if (keyCode == 'w'||keyCode == 'W') client.write("UP\n");
  if (keyCode == 's'||keyCode == 'S') client.write("DOWN\n");
  if (keyCode == 'a'||keyCode == 'A') client.write("LEFT\n");
  if (keyCode == 'd'||keyCode == 'D') client.write("RIGHT\n");
  if (key == ' ') client.write("SPACEBAR\n");
}
void keyReleased() {
  if (keyCode == 'w'||keyCode == 'W') client.write("!UP\n");
  if (keyCode == 's'||keyCode == 'S') client.write("!DOWN\n");
  if (keyCode == 'a'||keyCode == 'A') client.write("!LEFT\n");
  if (keyCode == 'd'||keyCode == 'D') client.write("!RIGHT\n");
}
