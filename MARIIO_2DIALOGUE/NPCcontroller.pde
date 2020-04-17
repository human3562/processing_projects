class controller {
  character NPC;
  boolean avoidPlayer = true;

  controller(character npc) {
    NPC = npc;
  }

  void Start() {
  }

  void Update() {
    if (avoidPlayer && NPC.yPosition - Player.yPosition < 64) {
      if (NPC.xPosition-Player.xPosition < 150 && NPC.xPosition - Player.xPosition >0) {
          NPC.right = true;
      } else NPC.right = false;

      if (Player.xPosition - NPC.xPosition < 150 && Player.xPosition - NPC.xPosition>0) {
        NPC.left = true;
      } else NPC.left = false;
    }
  }
}
