json.partial! 'metadata'
json.results @companies, partial: 'company/company', as: :company
