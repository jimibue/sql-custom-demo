class Customer < ApplicationRecord
  belongs_to :user

  def self.all_customers(user_id)
    Customer.find_by_sql("
      SELECT * FROM customers as c
      where c.user_id = #{user_id};
      ")
  end

  def self.single_customer(user_id, customer_id)
    Customer.find_by_sql(
      ["SELECT * FROM customers as c where c.user_id = ? AND c.id = ?",
       user_id,
       customer_id]
    ).first
  end

  def self.create_customer(customer, id)
    Customer.find_by_sql(
      ["INSERT INTO customers (first_name, last_name, email, phone, user_id, created_at, updated_at )
      Values (:first, :last, :email, :phone, :user_id, :created_at, :updated_at)
    ", {
        first: customer[:first_name],
        last: customer[:last_name],
        email: customer[:email],
        phone: customer[:phone],
        user_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now,
      }]
    )
  end

  def self.update_customer(customer, user_id)
    Customer.find_by_sql(["
      UPDATE customers AS c
      SET first_name = ?, last_name = ?, email= ?, phone= ?, updated_at = ?
      WHERE c.id = ?;
      ", customer[:first_name], customer[:last_name], customer[:email], customer[:phone], DateTime.now, user_id])
  end

  def self.destroy_customer(customer_id)
    Customer.find_by_sql("
      DELETE FROM customers as c
      WHERE c.id = #{customer_id}
      ")
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
