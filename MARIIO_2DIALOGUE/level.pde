class level {
  ArrayList<levelPointer> pointers = new ArrayList<levelPointer>();
  ArrayList<block> blocks;
  int blockcount;
  int levelWidth, levelHeight;
  int playerSpawnId;
  boolean completed = false;
  boolean isStarted = false;
  int levelId;

  void setLevel(JSONObject sLevel, JSONArray sLevelBlocks) {
    levelWidth = sLevel.getInt("levelWidth");
    levelHeight = sLevel.getInt("levelHeight");
    blockcount = levelWidth*levelHeight;
    levelId = sLevel.getInt("levelId");
    blocks = new ArrayList<block>();
    for (int i = 0; i < blockcount; i++) {
      JSONObject b = sLevelBlocks.getJSONObject(i);
      block added = new block();
      added.isSolid = b.getBoolean("isSolid");
      //added.destructible = b.getBoolean("destructible");
      added.ladder = b.getBoolean("ladder");
      added.textureId = b.getInt("textureId");
      added.positionX = b.getFloat("positionX");
      added.positionY = b.getFloat("positionY");
      added.isPointer = b.getBoolean("isPointer");
      if (added.isPointer) {
        pointers.add(new levelPointer(b.getInt("pointerBlockId"), b.getInt("pointerLevelId")));
      }
      blocks.add(added);
    }
    block extra = new block();
    extra.isSolid = false;
    extra.textureId = -1;
    blocks.add(extra);
  }

  void Start() {
  }

  void Update() {
    for (block b : blocks) {
      //if(b.textureId == -1) return;
      //println(blocks.size());
      if (b.positionX+32> -offsetX && b.positionX-32< -offsetX + width/scl && b.positionY+32> -offsetY && b.positionY-32< -offsetY+height/scl) {
        if (b.textureId!=-1) {
          b.texture = images.textureImages.get(b.textureId);
          image(b.texture, b.positionX, b.positionY, 64, 64);
        }
        if (b.ladder)
          image(images.ladder1, b.positionX, b.positionY, 64, 64);
        if (b.isCoin) {
          b.anim+=60*elapsedTime; 
          image(images.coin[floor(b.anim)%b.spriteAmt], b.positionX, b.positionY, 64, 64);
        }
      }
    }
  }
}


class levelPointer {
  int blockId;
  int levelId;
  levelPointer(int id, int level) {
    blockId = id;
    levelId = level;
  }
}
