# Padronização de Objetos
class GameObject < Sprite
  def initialize(x, y, img, w, h, z)
      super(
        img,
        x: x,
        y: y,
        width: w,
        height: h,
        z: z
      )

      @initial_pos_x = x
      @initial_pos_y = y
  end

  def check_collision(obj)
    # Verifica a colisão entre 2 objetos no eixo X/Y
    self.x > obj.x - obj.width &&
    self.x < obj.x + obj.width &&
    self.y > obj.y - obj.height && 
    self.y < obj.y + obj.height
  end
end