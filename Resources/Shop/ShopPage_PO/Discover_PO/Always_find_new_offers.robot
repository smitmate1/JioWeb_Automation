*** Settings ***
Library                                  SeleniumLibrary
Resource                                 ../../../Common.robot
Variables                                ../../../Common_Variables.yaml
Resource                                 ../../../../Resources/Excel_Activity.robot
Resource                                 ../../../Local_Keywords.robot


*** Keywords ***

Always find new offers section visibility, UI verification and is redirected to relevant product page on clicking on Buy Now button
    #Scroll To The Always Find New Offers Section
    Scroll To                            xpath=(//section[@class="l-layout--max-width"])[1]
    Read Data of Always Find New Offers section from Excel
    #Verify Always Find New Offers Section                     Testcase:92557
    Section Verification                 xpath=//body/div[@id='wrapper']/div[@id='page']/div[@id='content']/div[@id='root']/div[contains(@class,'main-container typography-container')]/section[1]    Always Find New Offer
    Text Verification                    xpath=//h2[normalize-space()='Always find new offers']    ${Always_Find_New_Offer_Heading}
    #Take Element Screenshot              xpath=(//section[@class="l-layout--max-width"])[1]        SC_AFNOVisible     
    
    #Verify Ui Elements Of 'Always Find New Offers' Section    Testcase:92558
    Text Verification                    xpath=//div[normalize-space()='Cashback, vouchers, and more!']    ${Always_Find_New_Offer_SubHeading}
    
    
    #Scroll To To 1st Banner Of Always Find New Offers
    Scroll To                            xpath=//div[@class="j-card__flex j-flex-column-reverse "]
    #Heading of Section
    Text Verification                    xpath=//h2[normalize-space()='Always find new offers']    Always find new offers

    #Content Verification Of The Banner
    Wait For And Verify Element        xpath=//section[@class='j-container'][contains(.,'61% off on Jio Extender6 MeshNow enjoy uninterrupted internet in every room.Buy NowIrresistible JioFi offer!Enjoy ₹1,500 cashback on JioFi worth ₹2,800. T&C Apply.Buy Now')]
    
    #Print Title Of Section I.E Always Find New Offer In The Console
    Log To Console                       ${Always_Find_New_Offer_Heading} 
    
    #Print Text Present Below The Heading Of Section In The Console
    Log To Console                       ${Always_Find_New_Offer_SubHeading}

    #Banner 1 Verification
    Text Verification    xpath=//h3[normalize-space()='61% off on Jio Extender6 Mesh']    ${Always_Find_New_Offer_ImageHeading}[0]
    Log To Console    ${Always_Find_New_Offer_ImageHeading}[0]
    Text Verification    xpath=//div[normalize-space()='Now enjoy uninterrupted internet in every room.']    ${Always_Find_New_Offer_ImageSubHeading}[0]
    Log to Console     ${Always_Find_New_Offer_ImageSubHeading}[0]

    #Banner 2 Verification
    Text Verification    xpath=//h3[normalize-space()='Irresistible JioFi offer!']    ${Always_Find_New_Offer_ImageHeading}[1]
    Log To Console    ${Always_Find_New_Offer_ImageHeading}[1]
    Text Verification    xpath=//div[contains(text(),'Enjoy ₹1,500 cashback on JioFi worth ₹2,800. T&C A')]    ${Always_Find_New_Offer_ImageSubHeading}[1]
    Log to Console     ${Always_Find_New_Offer_ImageSubHeading}[1]

    #Verify Buy Now Button Is Visible Or Not
    Wait For And Verify Element        xpath=(//button[@class='j-button j-button-size__small primary w-auto'][contains(.,'Buy Now')])[1]
    Wait For And Verify Element        xpath=(//button[@class='j-button j-button-size__small primary w-auto'][contains(.,'Buy Now')])[2]
    
    #User Is Transferred To Product Page Using Buy Now Button   Testcase:92559
    Scroll To                            xpath=//div[@class="overflow-scroll-max-width j-content-layout l-layout--max-width j-content-layout__layout-2-col-even carousel-card-wrap 2_column_carousel_function equal_height_card larger-screen"]
    Redirection On Clicking              xpath=(//button[@class="j-button j-button-size__small primary w-auto"])[1]    https://www.jio.com/shop/en-in/jioextender6-mesh-wi-fi-system/p/491894637    Sc_MeshWifiSystem 