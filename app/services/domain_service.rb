class DomainService

  def self.generate_parent_domain(name)
    main_domain_name = main_domain(name)

    if main_domain_name.present?
      return nil if (main_domain_name.eql? name) || (name.nil?)

      if Domain.find_by(name: main_domain_name).nil?
        Domain.create(name: name)
        main_domain = Domain.find_by(name: name)
        return main_domain
      else
        return Domain.find_by(name: main_domain_name)
      end
    end
  end

  def self.main_domain(name)
    return name if name.count('.') < 2
    return name.partition('.')[2] if name.count('.') == 2
    return nil
  end
end
