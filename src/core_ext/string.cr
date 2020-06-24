class String
  def climatize(*, strip = false, force = false) : String
    return Climate.strip(self, force: force) if strip
    Climate.parse(self)
  end
end
