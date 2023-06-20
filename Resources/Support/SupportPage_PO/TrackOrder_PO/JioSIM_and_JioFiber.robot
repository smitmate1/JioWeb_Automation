*** Settings ***
Library                        Dialogs
Resource                       ../../../Common.robot
Variables                      ../../../../Tests/Support/TrackOrder_Variables.yaml
Resource                       ../../../Excel_Activity.robot
Resource                       ../../../Local_Keywords.robot

*** Keywords ***
Functionality of 'Track order' Page Verification
    UI elements of Jio SIM and JioFiber page verification
    Input and Cross Button Functionality
    Entering Invalid Details and 'Enter valid order tracking details received' Error Verification 

UI elements of Jio SIM and JioFiber page verification
    # Testcase : 92625
    # Redirection to jiosim jiofiber page
    # Click on JioSIM and JioFiber
    Redirect and continue              xpath=//a[@aria-label='Jio SIM and JioFiber']//div[@class='j-listBlock__block-text']    ${TrackOrder_URLs}[0]    Sc_RedirectionTojioSim_and_jiofiber
    # Testcase : 92626
    #cube icon
    Wait For And Verify Element        xpath=//span[@class='submitDetails_orderIcon__Nn14l j-icon']
    #image on right side
    Wait For And Verify Element                 xpath=//img[@alt='Track Order Status of Jio Sim or JioFiber']   
    #heading
    Text Verification                  xpath=//h1[normalize-space()='Track order']                                             ${JioSim_JioFiber_heading}
    #subheading
    Text Verification                  xpath=//h2[contains(text(),'Find the status of your Jio SIM and JioFiber order')]       ${JioSim_JioFiber_Subheading}
    #Enter tracking details placeholder
    Text Verification                  xpath=//label[normalize-space()='Enter order tracking details']                         ${Placeholder_order}
    #Checking content of tracking details
    Text Verification                  xpath=//section[@class='MainContainer_desktopContent__2UMLN j-container']//div[@class='j-text j-text-body-s']    ${Tracking_details_content}
    #Hyperlink verification
    Wait For And Verify Element        xpath=//div[@class='j-text j-text-body-s-link']
    #proceed button
    Scroll To                          xpath=//button[@aria-label='button Proceed']
    Element Should Be Disabled         xpath=//button[@aria-label='button Proceed']
    #checking hyperlink functionality
    Hyperlink Popup
    Hyperlink Popup UI Elements
    Hyperlink cross button validation
    Input text field validation

Hyperlink Popup
    # Testcase : 92627
    #clicking on hyperlink
    Wait For And Click Element         xpath=//div[@class='j-text j-text-body-s-link']
    #verifying hyperlink popup
    Wait For And Verify Element        xpath=//div[contains(@class,'j-modal-container')]    

Hyperlink Popup UI Elements
    # Testcase : 92628
    #checking UI elements of popup
    #heading verification
    Text Verification                  xpath=//h5[normalize-space()='How to find order tracking details?']     ${Hyperlink_popup_heading}
    #content verification of popup
    Wait For And Verify Content        xpath=//div[contains(@class,'j-modal-container')]                       ${Hyperlink_content}    
    #checking cross icon of the popup    
    Wait For And Verify Element        xpath=//button[@class='j-button j-button-size__medium tertiary icon-primary icon-only']//i[@class='j-button-icon']

Hyperlink cross button validation
    # Testcase : 92629
    #clicking on cross icon
    Wait For And Click Element         xpath=//button[@class='j-button j-button-size__medium tertiary icon-primary icon-only']//i[@class='j-button-icon']
      
Input text field validation
    # Testcase : 92630
    # Clicking on Input field
    Wait For And Click Element         xpath=//*[@id="basic-input"]
    Wait For And Input Text            xpath=//*[@id="basic-input"]           SACXDSC
    # Testcase : 92631
    #Proceed button becomes active
    Scroll To                          xpath=//button[@aria-label='button Proceed']
    Wait Until Element Is Enabled      xpath=//button[@aria-label='button Proceed']

Input and Cross Button Functionality
    #92632
    Wait For And Verify Element        xpath=//span[@class="input-icon input-icon-suffix clickable"]
    # Clicking on cross button
    Wait For And Click Element         xpath=//span[@class="input-icon input-icon-suffix clickable"]
    # Verifying if the input field is empty
    ${emptyString} =    Get Text       xpath=//*[@id="basic-input"]
    Wait For And Verify Content        xpath=//*[@id="basic-input"]           ${emptyString}    

Entering Invalid Details and 'Enter valid order tracking details received' Error Verification
    # Testcase : 92633 
    # Entering invalid order details in the input field
    Wait For And Input Text            xpath=//*[@id="basic-input"]           QWERTY
    Scroll To                          xpath=//button[@aria-label='button Proceed']
    # Verifying if Proceed Button is enabled 
    Element Should Be Enabled          xpath=//button[@aria-label='button Proceed']
    Wait For And Click Element         xpath=//button[@aria-label='button Proceed']
    # Verifying if the user gets error toast
    Text Verification                  xpath=//div[@class='j-text j-text-body-s-bold']    Enter valid order tracking details    
    Enter details and Proceed
    # Testcase : 92634
    URL Validation                     ${TrackOrder_URLs}[0]    
    Take Page Screenshot               sc_RedirectionToNoOrderPage

UI of 'No Orders to Track' Page Verification
    # Testcase : 92635
    # No Orders to Track icon
    Wait For And Verify Element        xpath=//span[@class='noOrders_orderIcon__2vNyO j-icon']//*[name()='svg'] 
    # Heading
    Wait For And Verify Content        xpath=//h1[normalize-space()='No orders to track']                                   No orders to track
    # Sub Heading
    Text Verification                  xpath=//h2[contains(text(),'There is no order pending for your number. Please ')]    There is no order pending for your number. Please use other details to search again
    Scroll To                          xpath=//button[@aria-label="button Get Jio SIM"]
    # Image 
    Wait For And Verify Element                 xpath=//img[@alt='Track Order Status of Jio Sim or JioFiber']
    #Text under Check Another Order button
    Text Verification                  xpath=//div[normalize-space()='Meanwhile, you can order a new SIM or book a JioFiber connection online to enjoy seamless connectivity, fast internet, and complimentary benefits.']                                                                           ${NoOrderText}
    # Verifying if Get Jio SIM button is present 
    Wait For And Verify Element        xpath=//button[@aria-label="button Get Jio SIM"]    
    Text Verification                  xpath=//button[@aria-label="button Get Jio SIM"]                                     Get Jio SIM
    # Verifying if Get JioFiber button is present 
    Wait For And Verify Element        xpath=//button[@aria-label="button Get JioFiber"]
    Text Verification                  xpath=//button[@aria-label="button Get JioFiber"]                                                                 Get JioFiber
    # Verifying if Check Another button is present     
    Wait For And Verify Element        xpath=//button[@aria-label='button Check another order']
    Text Verification                  xpath=//button[@aria-label='button Check another order']                                                          Check another order
    CSS Verification                   xpath=//button[@aria-label='button Check another order']    background-color    rgba(15, 60, 201, 1)
    Redirection to 'Check Another Order' Page
    Redirection to 'Get Jio SIM' Page
    Redirection to 'Get Jio Fiber' Page 

Redirection to 'Check Another Order' Page     
    # Testcase : 92636   
    #verifying user redirects to check another order page
    Redirect and continue              xpath=//button[@aria-label='button Check another order']    ${TrackOrder_URLs}[0]            sc_RedirectionToCheckAnotherOrder   

Redirection to 'Get Jio SIM' Page
    # Testcase : 92637
    #verifying user redirects to 'Get Jio Sim' Page
    Wait For And Click Element         xpath=//*[@id="basic-input"]
    Enter details and Proceed
    #wait until is used as the page takes time to load
    Wait Until Keyword Succeeds        1 min    5 sec     Redirection On Clicking            xpath=//button[@aria-label="button Get Jio SIM"]             ${TrackOrder_URLs}[1]            GetJioSIM

Redirection to 'Get Jio Fiber' Page
    # Testcase : 92638
    #verifying user redirects to 'Get Jio Fiber' Page
    Wait For And Click Element         xpath=//*[@id="basic-input"]
    Enter details and Proceed
    Wait Until Element Is Visible      xpath=//button[@aria-label="button Get JioFiber"] 
    Redirection On Clicking            xpath=//button[@aria-label="button Get JioFiber"]          ${TrackOrder_URLs}[2]            GetJioFiber    

#-------------- To be discussed with UAT team -------------------
UI and Functionality of OTP Page Verification
    # Testcase : 92639
    # Using Valid Jio Number and Redirection to OTP page
    Wait For And Click Element         xpath=//*[@id="basic-input"]
    Wait For And Input Text            xpath=//*[@id="basic-input"]                               ${${TrackOrder_ValidJioNumber}}
    Redirect and continue              xpath=//button[@aria-label='button Proceed']               ${TrackOrder_URLs}[3]             sc_RedirectionToOtpPage
    # Testcase : 92640
    # OTP received successfully pop up
    Wait For And Verify Element        xpath=//div[@class="ErrorToast_notificationSuccessServiceStyle__1Vl2f j-notification j-notification__kind-service j-notification__duration-short"]    
    # Testcase : 92641    
    # Verify Identity icon
    Wait For And Verify Element        xpath=//span[@class="j-icon j-icon__bg"]   
    # Heading
    Text Verification                  xpath=//div[@class='j-text j-text-heading-xs']             Verify Identity
    # Sub Heading
    ${OTP_SENT}=    Get Text           xpath=//div[@class='txt-align--center j-text j-text-body-xs']
    Text Verification                  xpath=//div[@class='txt-align--center j-text j-text-body-xs']        ${OTP_SENT}
    # 6 digit Input Field
    Wait For And Verify Element        xpath=//div[@class='input-code__group']
    # Verifying if Resend Code button is present     
    Wait For And Verify Element        xpath=//button[@aria-label='button Resend code']
    # Verifying if Verify button is present     
    Wait For And Verify Element        xpath=//button[@aria-label="button Verify"]
    # Image
    Wait For And Verify Element                 xpath=//img[@alt='Track Order Status of Jio Sim or JioFiber']
    # Testcase : 92642
    # Resending code/OTP
    Wait For And Click Element         xpath=//button[@aria-label='button Resend code']
    Scroll To           xpath=//button[@aria-label="button Verify"]
    # Verifying if Verify button is disabled
    Element Should Be Disabled         xpath=//button[@aria-label="button Verify"]
    Wait For And Click Element         xpath=//input[@id='basic-input-testInput-code-block-0']
    # Entering data into first 3 blanks of input field
    Wait For And Input Text            xpath=//input[@id='basic-input-testInput-code-block-0']              123
    # Verifying if Verify button is disabled
    Element Should Be Disabled         xpath=//button[@aria-label="button Verify"]
    Wait For And Click Element         xpath=//input[@id='basic-input-testInput-code-block-3']    
    # Entering data into last 3 blanks of input field
    Wait for And Input Text            xpath=//input[@id='basic-input-testInput-code-block-3']              456
    # Testcase : 92643
    # Verifying if Verify button is enabled    
    Element Should Be Enabled          xpath=//button[@aria-label="button Verify"]
    Wait for And Click Element         xpath=//button[@aria-label="button Verify"]   
    # Testcase : 92644
    # Verifying if we receive error toast    
    Wait Until Element Is Visible      xpath=//div[@class='ErrorToast_notificationErrorStyle__KAzDY j-notification j-notification__kind-semantic j-notification__duration-short']
    Text Verification                  xpath=//div[@class='ErrorToast_notificationErrorStyle__KAzDY j-notification j-notification__kind-semantic j-notification__duration-short']        That's not the OTP we sent. Please re-enter and try again   
    # Testcase : 92645
    # Entering valid OTP
    Wait for And Click Element         xpath=//input[@id='basic-input-testInput-code-block-0']
    ${OTP} =                           GET Value From User                                            Enter OTP 
    Wait for And Input Text            xpath=//input[@id='basic-input-testInput-code-block-0']        ${OTP}
    Redirect and continue              xpath=//button[@aria-label="button Verify"]                    ${TrackOrder_URLs}[4]            sc_RedirectionToMyOrders 

UI of My orders Page Verification
    # Testcase : 92646
    # Heading
    Text Verification                 xpath=//h1[normalize-space()='My orders']                       My orders 
    # Sub Heading
    Text Verification                 xpath=//h2[normalize-space()='Find your recent orders']         Find your recent orders
    # Verifying Order Ticon
    ${Ordericon} =       Get WebElements     xpath=//div[@class='j-card size--xl card-horizontal j-card__shadow']
    FOR    ${OrderIcon}    IN                @{OrderIcon}
        Wait For And Verify Element          ${OrderIcon}
    END  
    # Verifying if arrows are present in each tile
     ${arrow} =    Get WebElements     xpath=//div[@class='j-card size--xl card-horizontal j-card__shadow']
    FOR    ${arrow}    IN              @{arrow}    
        Wait For And Verify Element    ${arrow}
    END
    # Verifying if Order title , status , Date and time is present
    ${TileContent} =    Get Text       xpath=//div[@class='j-card size--xl card-horizontal j-card__shadow']        
    FOR    ${OrderContent}    IN       xpath=//div[@class='j-card size--xl card-horizontal j-card__shadow']    
        Wait For And Verify Content    xpath=//div[@class='j-card size--xl card-horizontal j-card__shadow']    ${TileContent}
    END
    # Verifying if Check Another Order button is present     
    Wait For And Verify Element        xpath=//button[@class='j-button j-button-size__medium secondary']
    # Image Verification
    Wait For And Verify Element                 xpath=//img[@src="https://jep-asset.akamaized.net/jiocom/static/images/track_order_delivery.png"]
    Redirection to Track Order Page of Jio SIM and JioFiber Orders
    Redirection to Product Order Page
    UI and Content of Product Order Verification  
    Redirection to My Orders Page
    Confirm if pop-up appears on clicking on Need help with your order? hyperlink
    Pop-up Verification
    Redirection to Relevant Page 
    Redirection to Cashback Offer Page 
    
Redirection to Track Order Page of Jio SIM and JioFiber Orders
    # Testcase : 92647
    # Clicking on Another Order button
    Wait For And Click Element         xpath=//button[@class='j-button j-button-size__medium secondary']
    # Fetching URL
    ${currentURL} =                    Get Location
    URL Validation                     ${currentURL}
    Take Page Screenshot               sc_RedirectionToTrackOrderPage
    Go Back

Redirection to Product Order Page 
    # Testcase : 92648
    # Clicking on any tile 
    Wait For And Click Element         xpath=//div[@class='j-card size--xl card-horizontal j-card__shadow']
    # Fetching URL    
    ${currentURL} =                    Get Location
    URL Validation                     ${currentURL}
    Take Page Screenshot               sc_RedirectionToProductOrderPage

UI and Content of Product Order Verification  
    # Testcase : 92649
    #Verify product name, use excel
    ${OrderTitle} =    Get Text        xpath=(//div[@class="j-text j-text-heading-m"])[1]   
    Text Verification                  xpath=(//div[@class="j-text j-text-heading-m"])[1]    JioSIM     
    #Verify Order Id, use excel
    ${OrderID} =    Get Text           xpath=//div[@class="j-text j-text-body-s-bold"]
    Wait For And Verify Content        xpath=//div[@class="j-text j-text-body-s-bold"]       ${OrderID}
    #Verify date and time, use excel
    ${dateandTime} =    Get Text       xpath=(//div[@class="j-text j-text-body-s"])[2]    
    Wait For And Verify Content        xpath=(//div[@class="j-text j-text-body-s"])[2]       ${dateandTime}
    #Graphic depicting order journey
    ${Count} =    Get Count            xpath=//section[@class="j-container"]    xpath=//section[@class="j-container"]//span[@class="j-icon"]
    Log To Console    ${Count-1} Graphics
    #Verify order placed
    Wait For And Verify Content        xpath=(//div[@class="j-text j-text-body-m-bold"])[1]    Order placed
    #Verify delivery
    Wait For And Verify Content        xpath=//section[@class="deliveryDetails_deliveryDetailsContainer__1oq_A j-container"]   Delivery Details
    #Delivery details icon
    Wait For And Click Element         xpath=//div[@class="deliveryDetails_deliveryIcon__MXUpR"]
    #Delivery Address
    ${Deliverydetails} =    Get Text   xpath=//section[@class='deliveryDetails_deliveryDetails__1oto_ j-container']
    Text Verification                  xpath=//section[@class='deliveryDetails_deliveryDetails__1oto_ j-container']    ${Deliverydetails}
    #Verify Need help with your order Hyperlink
    Wait For And Verify Element        xpath=//span[@class='orderstatus_textButton__1dJmq j-text j-text-body-s-link']
    #Verify More from Jio Section
    Section Verification               xpath=//section[@class="orderstatus_moreFromJioContainer__3iCjw j-container"]    More from Jio
    #Verify More from Jio Title
    Wait For And Verify Content        xpath=(//div[@class="j-text j-text-heading-m"])[2]    More from Jio
    #Verify poster
    FOR  ${banner}  IN RANGE    1     3  
        Wait For And Verify Element    xpath=//div[@class="j-promo-card__content-body"][${banner}]
        Wait For And Verify Element             xpath=//div[@class="j-promo-card__image ratio-wide"][${banner}] 
        Wait For And Verify Element    xpath=//button[@class="j-button j-button-size__large primary"]//div[@class="j-text j-text-body-s"][${i}]
    END
    #Verify Explore partner offer button
    Wait For And Verify Element        xpath=//button[@class="orderstatus_partnerOffersBtn__2Lhvg j-button j-button-size__medium secondary"] 
    #Verify back button
    Wait For And Verify Element        xpath=//button[@aria-label='button Back']
    # Clicking on back button
    Wait For And Click Element         xpath=//button[@aria-label='button Back']
    
Redirection to My Orders Page
    # Testcase : 92650
    URL Validation                     ${TrackOrder_URLs}[5]
    Take Page Screenshot               sc_RedirectionToMyOrdersPage

Confirm if pop-up appears on clicking on Need help with your order? hyperlink
    # Testcase : 92651
    # Clicking on Order Cancelled tile
    Wait For And Click Element         xpath=//div[@class="j-card__flex"][1]
    # Clicking on Need help with your order? hyperlink
    Wait For And Click Element         xpath=//span[normalize-space()='Need help with your order?']
    # Confirm if Pop up appears
    Wait For And Verify Element        xpath=//div[@class="j-modal-container"]

Pop-up Verification
    # Testcase : 92652
    #Click on Need help on your Order
    Wait For And Verify Content        xpath=//span[normalize-space()='Need help with your order?']    Need help on your order?
    Wait For And Click Element         xpath=//span[normalize-space()='Need help with your order?']
    Take Page Screenshot               SC_Popup
    #Verify the heading on the pop up
    Wait For And Verify Content        xpath=//div[@class="j-text j-text-heading-xs"]    Need help on your order?Contact us
    #Verify call button
    Wait For And Verify Element        xpath=(//button[@class="j-button j-button-size__large primary icon-primary icon-primary-inline"])[1]
    #Verify call button text 
    Wait For And Verify Content        xpath=(//button[@class="j-button j-button-size__large primary icon-primary icon-primary-inline"])[1]        Call
    #Verify Email button
    Wait For And Verify Element        xpath=(//button[@class="j-button j-button-size__large primary icon-primary icon-primary-inline"])[2]
    #Verify Email button text
    Wait For And Verify Content        xpath=(//button[@class="j-button j-button-size__large primary icon-primary icon-primary-inline"])[2]       Email
    #Verify Cross button
    Wait For And Verify Element        xpath=//button[@class="j-button j-button-size__medium tertiary icon-primary icon-only"]
    Wait For And Click Element         xpath=//button[@class="j-button j-button-size__medium tertiary icon-primary icon-only"]

Redirection to Relevant Page 
    # Testcase : 92653
    # Clicking on any tile
    Wait for And Click Element         xpath=//button[@class="j-button j-button-size__medium tertiary icon-primary icon-only"]
    Scroll To                          xpath=//ul[@class="react-multi-carousel-track "]
    Redirection On Clicking            xpath=(//div[@class="j-text j-text-heading-s"])[1]             ${TrackOrder_URLs}[6]    sc_RedirectionToRelevantPage   

Redirection to Cashback Offer Page 
    # Testcase : 92654    
    # Click on Explore partner offers button
    Redirect and continue              xpath=//button[@aria-label='button Explore partner offers']    ${TrackOrder_URLs}[7]    sc_RedirectionToCashbackOfferPage

# ---------- Common keywords for Track Order Section ----------
Enter details and Proceed    
    Wait For And Input Text            xpath=//*[@id="basic-input"]          ${TrackOrder_MobileNumber}
    Wait For And Click Element         xpath=//button[@aria-label='button Proceed'] 