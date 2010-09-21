require 'nokogiri'

module DrupalHelpers
  # Import comments from a drupal website.  To use this, create a xml
  # export of the drupal "comments" table. By default, this script looks
  # for an export file named "drupal_comments.xml", but you can call it
  # whatever.
  def import_comments_from_xml_file (xml_file = "./drupal_comments.xml")
    f = File.open(xml_file)
    xmldoc = Nokogiri::XML(f)
    f.close
    
    comments = xmldoc.xpath("*/comments")
    results = comments.map do |drupal_comment| 
      {
        :username => drupal_comment.at_xpath('.//name').content,
        :email => drupal_comment.at_xpath('.//mail').content,
        :homepage => drupal_comment.at_xpath('.//homepage').content,
        :comment => drupal_comment.at_xpath('.//comment').content,
        :subject => drupal_comment.at_xpath('.//subject').content, 
        :hostname => drupal_comment.at_xpath('.//hostname').content, 
        :node_id => drupal_comment.at_xpath('.//nid').content,
        # drupal dates are in millis since epoch
        :created_at => Time.at(drupal_comment.at_xpath('.//timestamp').content),
        :updated_at => Time.at(drupal_comment.at_xpath('.//timestamp').content)
      }
    end
  end
end

