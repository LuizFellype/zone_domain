class DomainCheckHistoriesController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index }
      format.json { render json: DomainCheckHistoryDatatable.new(params) }
    end
  end

  def new
    @history = DomainCheckHistory.new
  end

  def create
    @history = DomainCheckHistory.new(history_params)
    if @history.save
      generate_domains(@history)
      redirect_to domain_check_histories_path
    else
      render :new
    end
  end

  def show
    domain_check_history = DomainCheckHistory.find(params[:id])
  end

  private

  def generate_domains(history)
    results = []
    domains = ['']
    has_extension = history_params[:extension].present?
    chars = history_params[:pattern].split('')

    chars.each do |char|
      ab = get_alphabets(char)

      if char.equal? chars.last
        for x in domains do
          for y in ab do
            domain = make_domain(x.to_s + y.to_s)
            results << domain unless domain.nil?
            if results.length > 100
              last_domain = results.pop
              DomainCheckJob.perform_later(results, history, has_extension)
              results = [last_domain]
            end
          end
        end

        DomainCheckJob.perform_later(results, history, has_extension, true) if results.length > 0
      else
        domains = domains.map {|x| ab.map {|y| x.to_s + y.to_s } }.flatten
      end
    end
  end

  def get_alphabets(char)
    vowels = ['a', 'e', 'i', 'o', 'u']
    consonants = ['b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z']
    char == "C" ? consonants : vowels
  end

  def make_domain(name)
    return if history_params[:starts_with].present? && name.start_with?(history_params[:starts_with])
    return if history_params[:omit].present? && name.include?(history_params[:omit])

    history_params[:extension].blank? ? name : [name, history_params[:extension]].join('.')
  end

  def history_params
    params.require(:domain_check_history).permit(:pattern, :extension, :starts_with, :omit)
  end
end
