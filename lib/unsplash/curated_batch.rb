module Unsplash # :nodoc: 

  # Unsplash Curated Batch operations.
  class CuratedBatch < Model

    class << self

      # Get a specific curated batch.
      # @param id [Integer] The ID of the batch.
      # @return [Unsplash::CuratedBatch] The requested batch.
      def find(id)
        new JSON.parse(connection.get("/curated_batches/#{id}").body)
      end

      # Get a list of all curated batches.
      # @param page  [Integer] Which page of search results to return.
      # @param per_page [Integer] The number of search results per page.
      # @return [Array] A single page of the +Unsplash::CuratedBatch+ list.
      def all(page = 1, per_page = 10)
        params = {
          page:     page,
          per_page: per_page
        }
        list = JSON.parse(connection.get("/curated_batches/", params).body)
        list.map { |cb| new cb }
      end
    end

    # Get a list of the photos contained in this batch.
    # @return [Array] The list of +Unsplash::Photo+s in the batch.
    def photos
      list = JSON.parse(connection.get("/curated_batches/#{id}/photos").body)
      list.map { |photo| Unsplash::Photo.new photo }
    end
  end
end