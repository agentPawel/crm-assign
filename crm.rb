require_relative 'contact'

class Crm

  def initialize(name)
    @name = name
    puts "Okay, this CRM has the name " + name
  end

  def main_menu
    while true
      print_main_menu
      user_selected = gets.to_i
      call_option(user_selected)
    end
  end

  def print_main_menu
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Search by attribute"
    puts "[6] Exit"
    puts "Enter a number: "
  end

  def call_option(user_selected)
    case user_selected
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then exit(0)
    end
  end

  def add_new_contact
    print "Enter First Name"
    first_name = gets.chomp

    print "Enter Last Name"
    last_name = gets.chomp

    print "Enter Email Address"
    email = gets.chomp

    print "Enter a Note"
    note = gets.chomp

    Contact.create(first_name, last_name, email, note)
  end

  def modify_existing_contact
    display_all_contacts
    print "Enter the ID of the contact you'd like to modify."
    by_id = gets.chomp.to_i

    contact_to_modify = Contact.find(by_id)

    if contact_to_modify == nil
      puts "No contact found with that ID."
      main_menu
    end

    attribute = nil

    while ( attribute == nil )
      attribute_menu
      user_selected = gets.to_i
      attribute = ( attribute_option(user_selected))
    end

    print "What is the new value?"
    new_value = gets.chomp.to_s

    contact.update(attribute, new_value)
    puts "You have successfully updated your contact!"
  end

  def attribute_menu
    puts "Which attribute?"
    puts '[1] First Name'
    puts '[2] Last Name'
    puts '[3] Email'
    puts '[4] Note'
  end

  def attribute_option(user_selected)
    case user_selected
      when 1 then attribute = "first_name"
      when 2 then attribute = "last_name"
      when 3 then attribute = "email"
      when 4 then attribute = "note"
      else
      attribute = nil
    end
    return attribute
  end

  def delete_contact
    display_all_contacts
    print "Enter the ID of the contact to delete: "
    id = gets.chomp.to_i
    contact_to_delete = Contact.find(id)
    display_a_contact(contact_to_delete)
    print "Are you sure you would like to delete this contact?(y/n) "
    answer = gets.chomp.downcase.to_s
    if answer == "y"
      contact_to_delete.delete
    else
      main_menu
    end
  end

  def display_all_contacts
    all_contacts = Contact.all
    all_contacts.each do |contact|
      puts "ID: #{contact.id} Name: #{contact.full_name} Email: #{contact.email} Note: #{contact.note}"
    end
  end

  def display_a_contact(contact)
    puts "ID: #{contact.id} Name: #{contact.full_name} Email: #{contact.email} Note: #{contact.note}"
  end

  def search_by_attribute
    print "Enter an attribute you would like to search: First Name, Last Name, Email and Note"
    attribute = gets.chomp.downcase.split(" ").join("_").to_s

    print "Enter the search value: "
    value = gets.chomp.downcase.to_s
    contacts = Contact.find_by(attribute, value)

    p "Here is the search result"
    contacts.each do |contact|
    display_a_contact(contact)
  end
end
