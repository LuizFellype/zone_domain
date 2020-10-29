class DomainCheckJob < ApplicationJob
  def perform(domains, history, has_extension = true, ended = false)
    existing_domains = if has_extension
      Domain.where(name: domains).pluck(:name)
    else
      Domain.where("split_part(name, '.', 1) IN (?)", domains)
    end

    new_domains = domains - existing_domains

    new_domains.each do |domain|
      AvailableDomain.create(name: domain, domain_check_history: history)
    end

    history.completed! if ended
  end
end
