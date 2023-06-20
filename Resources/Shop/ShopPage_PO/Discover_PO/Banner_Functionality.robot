*** Settings ***
Library                                                             SeleniumLibrary
Resource                                                            ../../../Common.robot
Variables                                                           ../../../../Tests/Shop/Discover_Variables.yaml
Resource                                                            ../../../Excel_Activity.robot
Resource                                                            ../../../Local_Keywords.robot


*** Keywords ***
Top Banner Carousel Section Verification
    #Verify Top Banner Under Discover Section Is Visible Or Not      Testcase:92536
    Section Verification                                             xpath=//section[contains(@class,"container masthead-slick fullscreen-slick-dots slick-initialized ")]    Discover Page   
    Reload Page
    Wait For And Click Element                                       xpath://ul[@class='slick-dots']//li[1] 

    # Confirm Top Banner Section Hovering Or Not                     Testcase:92540
    Mouse Over                                                       xpath:(//div[@class="bg-linear-gradient-banner"])[1]
    Sleep    6s    #Test case requirement
    Element Attribute Value Should Be                                xpath:(//ul[@class="slick-dots"]//li)[1]    class    slick-active

    # Check Whether Top Banner Carousel Is Moving Automatically Or Not    Testcase:92537
    Mouse Over                                                       xpath://ul[@class='slick-dots']//li[1] 
    Wait For And Click Element                                       xpath://ul[@class='slick-dots']//li[1] 
    ${Auto_Top_Banner}=    Set Variable    1 
    WHILE  ${Auto_Top_Banner}<4
        #Getting Slick Dot's Width
        ${css}=         Get WebElement                               xpath://ul[@class='slick-dots']//li[${Auto_Top_Banner}]
        ${width_slick}=    Call Method         ${css}                value_of_css_property    width
        
        Run Keyword And Continue on Failure    Should Be Equal As Strings     ${width_slick}    24px    #Some might face site issue so this keyword is kept
        
        Log To Console        Banner${Auto_Top_Banner}
        
        ${Auto_Top_Banner}=    Evaluate    ${Auto_Top_Banner}+1
        Sleep    5s    # Required Sleep
    END
    
    # Each Top Banner  Carousel Verification                           Testcase:92539,Testcase:92541
    FOR    ${Top_Banner}   IN RANGE    0    3
        # Clicking Sleek In Top Banner Carousel                       Testcase:92539
        Wait For And Click Element                                    xpath=//button[normalize-space()='${Top_Banner+1}']
        
        # Verifying  Each Banner In Top Banner Carousel
        Wait For And Verify Element                                   xpath=(//div[contains(@class,"j-fullwidth-banner-container d-flex align")])[${Top_Banner+1}]
        
        # Clicking Buttons Present In Top Banner Carousel        
        # Verifying Redirection After Clicking Each Button
        #Taking Screenshot After Clicking The Button In Top Banner Carousel        Testcase:92541
        Redirection On Clicking    xpath=(//button[@aria-label="button Button"])[${Top_Banner+1}]    ${Top_Banner_Redirecton}[${Top_Banner}]    Top_Banner_Redirection[${Top_Banner+1}]
    END

More reasons to shop here section visibility along with UI
    #Scroll To 'More Reason To Shop Here' Section                     Testcase:92560
    Scroll To                                                         xpath=(//section[@class="l-layout--max-width"])[2]
    #More Reason To Shop Here Section
    Section Verification                                              xpath=//div[@class="j-container pad-top-24 pad-bt-64 pad-bt-40"]    More reasons to shop here
    
   
    
    #Verify Ui Elements Of 'More Reasons To Shop Here' Section        Testcase:92561
    Read Data of More reason to Shop here section from Excel
    Image Verification                                                xpath=//img[@alt='Contactless delivery']
    Image Verification                                                xpath=//img[@alt='Original products']
    Image Verification                                                xpath=//img[@alt='Easy EMI options']
    #Scroll To Till More Reason To Shop Section Is Visible
    Scroll To                                                         xpath=//div[@class='j-container pad-top-24 pad-bt-64 pad-bt-40']//section[@class='j-container']
    
    #Print Title Of The Section In The Console
    Log To Console                                                 ${More_reasons} 
    
    #Verify Title Of The Section In The Console
    Text Verification                                              xpath=//h2[normalize-space()='More reasons to shop here']                                                                  ${More_reasons}
    
    #Print Text Present Below The Title Of The Section In The Console
    Log To Console                                                 ${Check_the_benefits}

    #Verify Text Present Below The Title Of The Section In The Console
    Text Verification                                              xpath=//div[normalize-space()='Check the benefits of buying your favourite device from Jio.']                              ${Check_the_benefits}
    
    #Gets The Count Of The Images Present 
    ${card_counts}=    Get Element Count                           xpath=(//img[@class='l-radius--large fill width-100pc'])     
    Log to Console                                                 ${card_counts}
    IF  ${card_counts} != 3
      Fail    msg=Images are more or less
    END

    #Verifies The Images Present
    FOR  ${card_count}  IN RANGE    ${card_counts}
        Wait For And Verify Element                                xpath=(//img[@class='l-radius--large fill width-100pc'])[${card_count+1}]
        
        #Verifies The Heading In The Images
        Log To Console                                             ${heading[${card_count}]} 
        Text Verification                                          xpath=(//h3[@class='j-text-heading-xs j-color-primary-grey-100 mg-bt-8'])[${card_count+1}]                                            ${heading[${card_count}]}
        
        #Verifies The Subcontent In The Images
        Log To Console                                            ${Receive_secure[${card_count}]} 
        Text Verification                                         xpath=(//div[@class='j-text-body-m j-color-primary-grey-100'])[${card_count+1}]                                                       ${Receive_secure[${card_count}]}
    END 

Need guidance? Section UI Verfification and Functionality
    #Scroll To To Need Guidance Section                          Testcase:92562
    Scroll To                                                    xpath=//section[@class="j-container bg--primary-background"]
    
    #Need Guidance Section                                       
    Section Verification                                         xpath=//section[@class='j-container bg--primary-background']    SC_NeedGuidance
    
    #Verify Ui Elements Of 'Need Guidance?' Section              Testcase:92563
    Read Data of Need Guidance? section from Excel
    
    #Heading of Section
    Text Verification                                            xpath=//h2[normalize-space()='Need guidance?']    Need guidance?


    #Verifies The Heading Of The Section
    Log To Console                                               ${Need_Guidance} 
    Wait For And Verify Content                                  xpath=//h2[contains(.,'Need guidance?')]                   ${Need_Guidance}
    
    #Verifies The Subtext Present Below The Heading
    Log To Console                                               ${We'd_love_to}
    Text Verification                                            xpath=//div[@class='j-contentBlock__description j-text-body-m j-color-primary-grey-80'][contains(.,'We’d love to help you.')]    ${We'd_love_to}
    Text Verification                                            xpath=//section[@class='j-container bg--primary-background']//a[1]    Support
    Text Verification                                            xpath=//a[@href='https://www.jio.com/en-in/help-support/call-us?nav=g#/']    Call us
    
    #User Is Transferred To Online Shopping Tab Under Support Section    Testcase:92564
    Redirection On Clicking                                      xpath=//a[@href="https://www.jio.com/en-in/help-support/frequently-asked-questions?parentId=1407507402270#/"]    https://www.jio.com/help/faq?parentId=1407507402270#/    Sc_SupportFAQ
    Go To                                                        https://www.jio.com/shop/homepage
    
    #User Is Transferred To Contact Tab On Clicking On Call Us Button    Testcase:92565
    Scroll To                                                    xpath=//a[@href="https://www.jio.com/en-in/help-support/call-us?nav=g#/"]
    Redirection On Clicking                                      xpath=//a[@href="https://www.jio.com/en-in/help-support/call-us?nav=g#/"]    https://www.jio.com/help/contact-us?tab=call?nav=g#/    Sc_CallusButton






    