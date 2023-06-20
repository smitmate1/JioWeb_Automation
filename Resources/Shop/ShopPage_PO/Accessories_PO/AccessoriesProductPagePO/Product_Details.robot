*** Settings ***
Resource                                        ../../../../Local_Keywords.robot


*** Keywords ***

Checking UI of Accessories Cards
    #Scrolling products into view             Testcase: 92769
    Scroll To                                 xpath=//div[contains(@class,"product-container") and contains(@onclick,"${URL_listShop[${Product_name}-1]}")]
    Wait For And Verify Element                        xpath=//div[contains(@class,"product-container") and contains(@onclick,"${URL_listShop[${Product_name}-1]}")]//div[@class='col-lg-12 col-xs-4 prod-image']
    Checking Product Name
    Checking Product Specs
    Checking Product Price
    Checking Redirection on Product           #Testcase: 92770 


Checking UI of Accessories Product Page
    Checking Product Accessories Page UI                                    
    Checking Device Specs & View Details                                        # Test Case : 92772, 92786
    Confirm redirection of the breadcrumbs hyperlinks                           # Test Case  : 92784
    Checking "View All Specifications"                                          # Test Case : 92787
    SlideShow Gallery Verification                                              # Test Case  : 92783,92785

Checking UI and functionality of Pincode and Delivery Section
    Pincode Verification                

Checking Accordion Functionality
    Open All Accordions                # Test Case : 92792

Full UI Accessories
    Checking All Products
    Scroll To                                         xpath://div[@class='col-lg-12 prod-title-wrap']     # Test case : 92768
    Wait For And Verify Content                       xpath://div[@class='col-lg-12 prod-title-wrap']    All Products
    ${Product_names} =    Get Element Count           xpath=//div[contains(@class, "product-container")]
    FOR  ${Product_name}  IN RANGE    1    ${Product_names+1}
        Set Test Variable    ${Product_name}
        Checking UI of Accessories Cards                           #Testcase: 92769,92770
        Checking UI of Accessories Product Page                    #Testcase: 92771
        Checking UI and functionality of Pincode and Delivery Section
        Checking Accordion Functionality
        Delete All Cookies
        Reloading Page
        Wait For And Click Element                   xpath=//section[@class="j-container"]/a[@aria-label="Accessories"]
        Sleep    200ms
    END
    Scroll To                                  xpath://div[@class='footer-wrapper']
    Wait For And Verify Element                xpath://div[@class='footer-wrapper']

Checking Product Accessories Page UI
    
    #Left side Section

    #Slideshow Images UI
    #Up Scroll Button
    Wait For And Verify Element    xpath=//div[@class='jcarousel-prev jcarousel-prev-vertical']
    #Multiple Images
    Wait For And Verify Element    xpath=//div[contains(@class,'col-lg-2 sol-md-2 col-sm-12')]
    CSS Verification               xpath=//div[contains(@class,'col-lg-2 sol-md-2 col-sm-12')]    float    left
    #Primary Image
    Wait For And Verify Element    id=primary_image
    #Down Scroll Button
    Scroll To                      xpath=//div[@class='jcarousel-next jcarousel-next-vertical']
    Wait For And Verify Element    xpath=//div[@class='jcarousel-next jcarousel-next-vertical']

    #Right side Section
    
    Wait For And Verify Element    xpath=//div[@class='col-lg-5 scroll-content-right']
    
    #Checking Breadcrum 
    Scroll To                      xpath=//section[@class='j-container l-layout--max-width breadcrumb-wrapper']
    Wait For And Verify Element    xpath=//section[@class='j-container l-layout--max-width breadcrumb-wrapper']

    #Checking Device Name
    Wait For And Verify Element    xpath=//h2[@itemprop="name"]

    #Checking Device Price
    Wait For And Verify Element    xpath=//span[@class='product-price']

    #Checking EMI Section and View Details
    Wait For And Verify Element    xpath=//div[@class='discount-emi-wrapper']

    #Checking About this item Content
    Scroll To                      xpath=//div[@class='description-content-block']
    Wait For And Verify Element    xpath=//div[@class='description-content-block']

    #Checking View All Specifications
    Scroll To                      xpath=//div[@class='description-button-block']
    Wait For And Verify Element    xpath=//div[@class='description-button-block']

    #Checking Eligible for delivery? Section
    Wait For And Verify Element    xpath=//div[@class='digi-pdp-right clearfix width-100pc pad-0 mg-top-32']
    Wait For And Verify Element    xpath=//input[@id='address.postcode']
    Wait For And Verify Element    xpath=//button[@id='pincode-button']

    #Checking Quantity Section
    Scroll To                      xpath=//button[@aria-label='Increase quantity']
    Wait For And Verify Element    xpath=//button[@aria-label='Decrease quantity']
    Wait For And Verify Element    xpath=//button[@aria-label='Increase quantity']

    #Checking Add to Cart Button
    Wait For And Verify Element    xpath=//button[@id='AddToCartBTN']

    #Checking Return Policy 
    Scroll To                      xpath=//div[@class='prod-return-policy-text']//span
    Wait For And Verify Content    xpath=//div[@class='prod-return-policy-text']//span    For our return policy    
    Wait For And Verify Content    xpath=//a[@href='http://www.jio.com/en-in/rrl-policy']    Click here   

    #Checking Sales and Distribution Section
    Wait For And Verify Content    xpath=//div[@class='sales-distribution-block']//span    Sale & distribution by Reliance Retail Ltd.
    
    #Checking Key Features Accordion Default Open
    Scroll To                      xpath=//a[@title="Key Features" and @aria-expanded="true"]
    Wait For And Verify Element    xpath=//a[@title="Key Features" and @aria-expanded="true"]

    #Checking Technical Specs
    Scroll To                      xpath=//a[@title="Technical Specs"]
    Wait For And Verify Element    xpath=//a[@title="Technical Specs"]

    #Checking Shipping & Delivery
    Scroll To                      xpath=//a[@title="Shipping & Delivery"]
    Wait For And Verify Element    xpath=//a[@title="Shipping & Delivery"]

    #Checking Shipping & Delivery
    Wait For And Verify Element    xpath=//a[@title="Offers & Information"]
    Go Back
    ${Current_Location}=    Get Location
    IF  "${Current_Location}" == "${Shop_SubNavBar_URL}[4]"
        Log To Console    continue
    ELSE
        Go Back   
    END
    
    Checking Redirection on Product

Checking All Products

    #Getting URL List from Excel
    ${Prod_URL}=    Read Excel Column    4    18    15    ${sheet}
    @{URL_listShop}=    Create List
    FOR    ${element}    IN    @{Prod_URL}
        ${element}=    Fetch From Right    ${element}    /
        Append To List    ${URL_listShop}    ${element}    
        
    END
    Log    ${URL_listShop}
    Set Test Variable    ${URL_listShop}    ${URL_listShop}
    ${count}    Set Variable
    #----- Code Below will notify us which product has been added to Smartphone by comparing it to already prepared Excel Data
    #Comparing Page Products URL with Excel URL list
    # ${Product_names} =    Get Element Count         xpath=//div[contains(@class, "product-container")]
    # FOR    ${counter}    IN RANGE    1    ${Product_names+1}
    #     Scroll To        xpath=//div[contains(@class, "product-container")][${counter}]
    #     ${Url_product}=    Get Element Attribute    //div[contains(@class, "product-container")][${counter}]    onclick
    #     ${Url_product}=    Fetch From Right    ${Url_product}    /
    #     ${Url_product}=    Remove String       ${Url_product}    "
        
    #     FOR    ${element}    IN    @{URL_listShop}
            
    #         IF  "${Url_product}" == "${element}"
    #             ${count}=    Evaluate    ${count}+1
    #             Exit For Loop
    #         END
            
    #     END 
    #     IF    "${count}" != "1"
    #         Run Keyword And Continue On Failure    FAIL
    #     END
    #     ${count}=    Evaluate    0
    # END