class Machine
  def start
    self.flip_switch(:on)
  end

  def stop
    self.flip_switch(:off)
  end

  private
  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end