class Hash
  def delete_empty
    delete_if do |_, value|
      value.instance_of?(Hash) && value.delete_empty.empty?
    end
  end
end
