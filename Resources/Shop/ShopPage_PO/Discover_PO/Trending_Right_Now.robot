*** Settings ***
Library                                         SeleniumLibrary
Resource                                        ../../../Common.robot
Variables                                       ../../../Common_Variables.yaml
Resource                                        ../../../../Resources/Excel_Activity.robot
Resource                                        ../../../../Resources/Local_Keywords.robot



*** Keywords ***
Trending right now section visibility, UI verification and redirection
    #Trending Right Now Section Visible After Scrolling
    Scroll To                                      xpath=//div[@class="j-rich-text j-text"]//h2[@class="j-heading j-text-heading-l txt-align-center"][1]
    
    #Section Verification                                     Testcase: 92554 
    Section Verification                           xpath://body/div[@id='wrapper']/div[@id='page']/div[@id='content']/div[@id='root']/div[contains(@class,'main-container typography-container')]/section[1]    Trending Right Now
    
    #Verifying Ui Elements Of 'Trending Right Now' Section    Testcase: 92555
    Read Data of Trending right now section from Excel
    #Heading & Sub-Heading of Section
    Text Verification                              xpath=//h2[normalize-space()='Trending right now']    Trending right now
    Wait For And Verify Element                    xpath=//div[normalize-space()='Our pick of the best in tech.']

    #Scroll To till section is visible
    Scroll To                                     xpath=//h2[normalize-space()='Always find new offers']

    #Verify The Title Of The Section
    Log To Console                               ${Trending_now}
    Text Verification                        xpath=//h2[normalize-space()='Trending right now']     ${Trending_now}
    
    #Gets The Count Of The Images Present
    ${card_count}=    Get Element Count           xpath=(//img[@class='img-container max-height-3-card'])     
    Log To Console    ${card_count}
    IF  ${card_count} != 3
      Fail    msg=Images are more or less
    END

    #Verifies The Name Of The Product
    ${j}=    Evaluate    0
    FOR  ${i}  IN RANGE   0    3
        #Verifies The Images Present
        Wait For And Verify Element               xpath=(//img[@class='img-container max-height-3-card'])[${i+1}]
        
        Log To Console                           ${Name_of_product[${i}]} 
        Text Verification                    xpath=(//h3[@class='j-contentBlock__title j-color-primary-grey-100 j-text-body-s-bold text-overflow'])[${i+1}]    ${Name_of_product[${i}]}
        
        #Verify The Color Of The Sticky Tags Present
        CSS Verification                          xpath=(//div[@class="j-badge j-badge-size__small"])[${i+1}]    background-color    rgba(12, 82, 115, 1)

        #Verifies The Prices And The Color Of The Product
        Log To Console                            ${Price[${i}]} 
        Wait For And Verify Content               xpath=(//div[@class="j-contentBlock__description j-color-primary-grey-80 j-text-body-s empty-text-height"])[${i+1}]    ${Price[${j}]}
        Wait For And Verify Content               xpath=(//div[@class='j-contentBlock__description j-color-primary-grey-80 j-text-body-s'])[${i+1}]                      ${Price[${j+1}]}
        ${j}=    Evaluate    ${j}+2
    END
    
    #Verify The Redirection After Clicking On Trending Right Now Product    Testcase: 92556
    Scroll To                                     xpath=//div[@class="j-rich-text j-text"]//h2[@class="j-heading j-text-heading-l txt-align-center"][1]
    Redirection On Clicking                       xpath=//div[@class='j-grid mg--top grid-product-set3']//a[3]     https://www.jio.com/shop/en-in/usb-camera/p/491581400    Sc_TRNProduct
