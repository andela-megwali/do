module Paginate
  def paginate(limit_query, page_query)
    limit(paginate_limit(limit_query)).
      offset(paginate_page(limit_query, page_query))
  end

  def paginate_limit(limit_query)
    limit_query = 20 if limit_query.to_i < 1
    limit_query = 100 if limit_query.to_i > 100
    limit_query.to_i
  end

  def paginate_page(limit_query, page_query)
    page_query = 1 if page_query.to_i < 1
    paginate_limit(limit_query) * (page_query.to_i - 1)
  end
end
