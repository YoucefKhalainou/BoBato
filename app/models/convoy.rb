class Convoy < ApplicationRecord
  has_many_attached :pictures
	belongs_to :boat_owner, class_name: 'User'
	has_one :delivery, dependent: :destroy
	has_many :submissions, dependent: :destroy
	has_many :applicants, through: :submissions, :source => :skipper

	validates :date_of_departure, presence: { message: "Il n'y a pas de date de départ"}
  validates :date_of_arrival, presence: { message: "Il n'y a pas de date d'arrivée"}
  validates :convoy_price, presence: { message: "Il n'y a pas de prix"}
  validates :convoy_price, numericality: { greater_than: 0 , message: "Le prix doit être supérieur à 0"}
  validates :boat_type, presence: { message: "Il faut spécifier le type de votre bateau"}
  validate :departure_must_be_in_future
  validate :departure_must_be_before_arrival
  $boat_types = ["Yacht", "Catamaran", "Voilier", "Chalutier", "Péniche", "Bateau-corsaire", "Deux-mâts", "Trois-mâts", "Bâteau cabine", "Croiseur", "Hors-Bord", "Bateau maison"]
  $departure_ports = ["Marseille", "Mykonos", "Barcelone", "Athènes", "Tanger", "Genes", "Hambourg", "Rotterdam", "Amsterdam", "Saint-Nazaire", "Le Havre", "Bizerte", "Brighton"]
  $arrival_ports = ["Toulon", "Ajaccio", "Bonifacio", "Split", "Palerme", "Dubrovnik", "Le Pirée", "Malaga", "Ibiza", "Hyères", "Naples", "Syracuse", "Trapani", "Lipari", "Cagliari"]
  acts_as_taggable_on :departure_ports
  acts_as_taggable_on :boat_types
  after_create :convoy_conf_email_send
  after_create :create_tag

  include PgSearch::Model 


  pg_search_scope :global_search,
    against: [:title, :description],
    associated_against: {
      departure_ports: [:name],
      boat_types: [:name]
    },
    using: {
      tsearch: {prefix: true}
    }

  def create_tag
    self.update(departure_port_list: self.departure_port)
    self.update(boat_type_list: self.boat_type)
  end

  def duration
  	(self.date_of_arrival - self.date_of_departure).to_i
  end


  def outdated_convoy
    if self.date_of_departure < Time.now
      return true
    else
      return false
    end
  end


  def convoy_conf_email_send
    UserMailer.convoy_conf_email(self).deliver_now
  end


  def update_submissions_status_after_checkout(skipper)
  	self.submissions.each do |submission|
	  	if submission.skipper == skipper
	  		submission.update(status: true)
	  	else
	  		submission.update(status: false)
        UserMailer.submission_fail_email(submission).deliver_now
	  	end
	  end
  end

  def picture_attachment_path
    self.pictures.attached? ? pictures.last() : 'no-picture.png'
  end

	private


	def departure_must_be_in_future
    if date_of_departure.nil?
      errors.add(:date_of_departure, "La date de départ doit être renseignée")
    elsif date_of_departure < Time.now
      errors.add(:date_of_departure, "La date de départ doit être supérieure à la date du jour")
    end
  end


	def departure_must_be_before_arrival
	  return unless date_of_departure and date_of_arrival
	  errors.add(:date_of_departure, "La date de départ doit être avant la date d'arrivée") unless date_of_departure < date_of_arrival
	end



end
