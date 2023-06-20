*** Settings ***
Resource                        ../../../../Local_Keywords.robot
Resource                       ../SmartDevicesProductPagePO/ProductDetails.robot

*** Keywords ***
Checking UI of SmartDevices Cards
    #Scroll to Product Title
    Scroll To                   xpath=//div[contains(@class,"product-container") and contains(@onclick,"${URL_listShop[${Product_name}-1]}")]

    #Verify Product Image
    Wait For And Verify Element          xpath=//div[contains(@class,"product-container") and contains(@onclick,"${URL_listShop[${Product_name}-1]}")]//div[@class='col-lg-12 col-xs-4 prod-image']

    #Verify Product Name
    Checking Product Name

    #Verify Product Specifications
    Checking Product Specs

    #Verify Product Price
    Checking Product Price

    #Verify Redirection on clicking on Product                        Testcase: 92670
    Checking Redirection on Product

Full UI Smart Devices
    
    Checking All Products

    #Testcase: 92669
    #Verifying Whether Show Filter Option is visible
    Wait For And Verify Element    //div[@class='filter-container']
    CSS Verification               //div[@class="filter-container"]    float     right
    
    # !!!! Most popular/Most Value Code is Written in Most Popular/Most Value Testcase  !!!!  TC27-SSmartDevices

    #Get Element Count Of Listed Under All Products
    Scrolling to All Products
    ${Product_names} =    Get Element Count     xpath=//div[contains(@class, "product-container")]
    # FOR Loop to Check UI of products listed under All Products       
    FOR  ${Product_name}  IN RANGE    1    ${Product_names+1}
        Set Test Variable    ${Product_name}
        Checking UI of SmartDevices Cards
        Checking UI & Functionality of SmartDevices Product Page                        
        Checking UI and functionality of Pincode and Delivery Section
        Checking Accordion Functionality                                #Testcase: 92689,92690,92691,92692,92693
        Delete All Cookies
        Go Back
    END

    #Scroll down and Verify Footer Section 
    Scroll To                           xpath=//div[@class='footer-wrapper']
    Wait For And Verify Element         xpath=//div[@class='footer-wrapper']

Checking Product Smart Devices Page UI
    
    #Left side Section

    #Slideshow Images UI
    #Up Scroll Button
    Wait For And Verify Element    xpath=//div[@class='jcarousel-prev jcarousel-prev-vertical']
    #Multiple Images
    Wait For And Verify Element    //div[contains(@class,'col-lg-2 sol-md-2 col-sm-12')]
    CSS Verification    //div[contains(@class,'col-lg-2 sol-md-2 col-sm-12')]    float    left
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
    Wait For And Verify Element    xpath=//div[@class='view-emi-button']

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

    #Checking Color Section
    Scroll To                      xpath=//div[@class='col-lg-12 col-md-12 col-sm-12 col-xs-12 colour-content']
    Wait For And Verify Element    xpath=//div[@class='col-lg-12 col-md-12 col-sm-12 col-xs-12 colour-content']

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
    Checking Redirection on Product

Checking All Products

    #Getting URL List from Excel
    ${Prod_URL}=    Read Excel Column    4    18    23    ${sheet}
    @{URL_listShop}=    Create List
    FOR    ${element}    IN    @{Prod_URL}
        ${element}=    Fetch From Right    ${element}    /
        Append To List    ${URL_listShop}    ${element}    
        
    END
    Log    ${URL_listShop}
    Set Test Variable    ${URL_listShop}    ${URL_listShop}
    # ${count}    Set Variable
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

    # ${count_smartdevices}=    Get Element Count    //div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container']
    # FOR    ${element}    IN RANGE    1    ${count_smartdevices+1}
    #     Scroll To    (//div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container'])[${element}]
    #     ${product_name}=    Get Text    (//div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container'])[${element}]//div[@class="pop-prod-title"]
    #     ${product_desc}=    Get Text    (//div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container'])[${element}]//div[@class="pop-prod-desc mg-bt-8"]
    #     ${product_price}=    Get Text    (//div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container'])[${element}]//div[@class="pop-prod-desc mg-bt-0"]
    #     ${product_url}=    Get Element Attribute    (//div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container'])[${element}]    onclick
    #     ${product_price}=    Remove String    ${product_price}    ,
    #     ${product_price}=    Remove String    ${product_price}    ₹

    #     #Converting Price Text to Integer 
    #     ${product_price}=    Convert To Integer    ${product_price}
       
    #     Write Excel Cell    row_num=${element+18}    col_num=1    value=${product_name}    sheet_name=${sheet}
    #     Write Excel Cell    row_num=${element+18}    col_num=2    value=${product_desc}    sheet_name=${sheet}
    #     Write Excel Cell    row_num=${element+18}    col_num=3    value=${product_price}    sheet_name=${sheet}
    #     Write Excel Cell    row_num=${element+18}    col_num=4    value=${product_url}    sheet_name=${sheet}
    #     Save Excel Document    Resources/JioWeb.xlsx
    # END
