class InCheckError < StandardError
  def initialize(msg = "You can't move yourself into check")
    super
  end
end

