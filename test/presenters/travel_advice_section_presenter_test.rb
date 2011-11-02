# encoding: UTF-8

require 'test_helper'

class TravelAdviceSectionPresenterTest < ActiveSupport::TestCase

  test 'strips style atttibutes' do
    section = {
      'title' => "Hello World",
      'section_markup_id' => 'helloWorld',
      'body' => {
        'markup' => "<p>Hello <span style=\"color: red\">red</span> world.</p>"
      }
    }

    html = TravelAdviceSectionPresenter.new(section).html
    assert_equal "<h1>Hello World</h1><p>Hello <span>red</span> world.</p>", html
  end

  # test 'using example content' do
  #   html = TravelAdviceSectionPresenter.new(example_section).html
  #   assert_equal "", html
  # end

  # def example_section
  #   {"body"=>{"markup"=>"<p id=\"travelSummary\"><b>Travel Summary</b><br><br></p><p>\n  \n</p>\n<ul>\n<li>\n<strong>Demonstrations can quickly turn violent in Bangladesh. General strikes (\"hartals\") have been fairly frequently over the past few months and more hartals are likely to be called in the future. See </strong><a title=\"Bangladesh - Chittagong\" href=\"http://www.fco.gov.uk/en/travel-and-living-abroad/travel-advice-by-country/asia-oceania/bangladesh#chittagonghilltracts\"><strong>\n\t\t\t\t<span style=\"text-decoration: underline\">Safety and Security - Local Travel - Chittagong H</span>ill Tracts.</strong></a><br><br>\n</li>\n<li>\n<strong>A nationwide ‘hartal’ (general strike) has been called by the opposition Bangladesh Nationalist Party and its allies from 06:00 to 18:00 on Thursday 22 September 2011.  It is anticipated that there will be disruption during the evening of 21 September which may include the burning of buses and other public vehicles, road blocks, small processions, demonstrations and rallies with potential for some violence.  British nationals are advised to exercise caution and consider this in any planned travel arrangements, particularly around Dhaka and other major cities.  You should avoid demonstrations and remain vigilant.  <a title=\"Bangladesh - civil unrest, hartals and demos\" href=\"http://www.fco.gov.uk/en/travel-and-living-abroad/travel-advice-by-country/asia-oceania/bangladesh#civilunrestetc\">Safety and Security - Local Travel - Civil Unrest/Hartals/Demonstrations.</a></strong><strong><br></strong><br>\n</li>\n<li>\n<strong>There is a general threat from <a title=\"Bangladesh - terrorism\" href=\"http://www.fco.gov.uk/en/travel-and-living-abroad/travel-advice-by-country/asia-oceania/bangladesh#terrorism\">terrorism.</a> Attacks cannot be ruled out and could be indiscriminate, including in places frequented by expatriates and foreign travellers.</strong><br><br>\n</li>\n<li>\n<strong>Up to 75,000 British nationals visit Bangladesh every year. 70 British nationals required consular assistance in Bangladesh in the period 1 April 2010 - 31 March 2011. See </strong><a title=\"Bangladesh: Cons Asst Stats\" href=\"http://www.fco.gov.uk/en/travel-and-living-abroad/travel-advice-by-country/asia-oceania/bangladesh#stats\"><strong>General - Consular Assistance - Statistics.</strong></a><strong> <br><br></strong>\n</li>\n<li><strong>You should take out comprehensive travel and medical insurance before travelling. See General - <a title=\"Bangladesh - insurance\" href=\"http://www.fco.gov.uk/en/travel-and-living-abroad/travel-advice-by-country/asia-oceania/bangladesh#insurance\">Insurance.</a></strong></li>\n</ul>", "plain"=>"Travel Summary\r\n\r\n\n  \n\n\nDemonstrations can quickly turn violent in Bangladesh. General strikes (\"hartals\") have been fairly frequently over the past few months and more hartals are likely to be called in the future. See \n\t\t\t\tSafety and Security - Local Travel - Chittagong Hill Tracts.\r\n\r\n\n\nA nationwide ‘hartal’ (general strike) has been called by the opposition Bangladesh Nationalist Party and its allies from 06:00 to 18:00 on Thursday 22 September 2011.  It is anticipated that there will be disruption during the evening of 21 September which may include the burning of buses and other public vehicles, road blocks, small processions, demonstrations and rallies with potential for some violence.  British nationals are advised to exercise caution and consider this in any planned travel arrangements, particularly around Dhaka and other major cities.  You should avoid demonstrations and remain vigilant.  Safety and Security - Local Travel - Civil Unrest/Hartals/Demonstrations.\r\n\r\n\n\nThere is a general threat from terrorism. Attacks cannot be ruled out and could be indiscriminate, including in places frequented by expatriates and foreign travellers.\r\n\r\n\n\nUp to 75,000 British nationals visit Bangladesh every year. 70 British nationals required consular assistance in Bangladesh in the period 1 April 2010 - 31 March 2011. See General - Consular Assistance - Statistics. \r\n\r\n\n\nYou should take out comprehensive travel and medical insurance before travelling. See General - Insurance.\n"}, "original_url"=>"http://www.fco.gov.uk/content/en/travel-advice/asia-oceana/12390734/fco_trv_ca_bangladesh?ta=travelSummary", "section_markup_id"=>"travelSummary", "title"=>"Bangladesh Travel Summary"}
  # end

end