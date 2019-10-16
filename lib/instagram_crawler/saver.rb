module InstagramCrawler
  class Saver
    class << self

      attr_accessor :items

      def init
        return unless Config.save

        @items = []
      end

      def add(type, url, time, node)
        return unless Config.save

        if !node.key?('shortcode')
          alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_'
          instagram_id = node['id'].to_i
          shortcode = ''

          while instagram_id > 0 do
            remainder = instagram_id % 64
            instagram_id = (instagram_id-remainder) / 64
            shortcode = alphabet[remainder] + shortcode
          end
        else
          shortcode = node['shortcode']
        end

        @items.push({
            type: type,
            url: url,
            time: time,
            node: node,
            credit: "https://www.instagram.com/p/#{shortcode}"
        })
      end
    end
  end
end
