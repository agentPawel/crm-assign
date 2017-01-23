class Contact

  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :note

  @@contacts = []
  @@id = 1

  def initialize (first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
    @id = @@id
    @@id += 1
  end

  def self.create (first_name, last_name, email, note)
    new_contact = Contact.new(first_name, last_name, email, note)
    @@contacts << new_contact
    new_contact
  end

  def self.all
    @@contacts
  end

  def self.find(id)
    @@contacts.each do |contact|
      return contact if contact.id == id
  # Or how do we break this?
    end
  end

  def update(attribute_to_update, new_value)
    case attribute_to_update
    when :first_name
      self.first_name = new_value
    when :last_name
      self.last_name = new_value
    when :email
      self.email = new_value
    when :note
      self.note = new_value
    end
  end

  def self.find_by(attribute_to_search, attribute_value)
    @@contacts.each do |contact|
    return contact if attribute_to_search == :first_name && contact.first_name == attribute_value
    return contact if attribute_to_search == :last_name && contact.last_name == attribute_value
    return contact if attribute_to_search == :email && contact.email == attribute_value
    return contact if attribute_to_search == :note && contact.note == attribute_value
    #what is potential escape if nothing is found.
    end
  end

  def self.delete_all
    @@contacts = []
  end

  def full_name
    return "#{first_name} #{last_name}"
  end

  def delete(contact)
    @@contacts.delete(self)
  end
end
