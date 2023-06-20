*** Settings ***
Resource                            ../../../../Local_Keywords.robot
Resource                            ../../Smartphone_PO/SmartphonePagePO/AllProducts.robot

*** Keywords ***
Checking UI of Smartphone Product Page
    Checking Product Smartphone Page UI                        #Testcase: 92577
    Checking Device Specs & View Details                       #Testcase: 92580,92581
    Confirm redirection of the breadcrumbs hyperlinks          #Testcase: 92578
    Checking "View All Specifications"                         #Testcase: 92582
    SlideShow Gallery Verification                             #Testcase: 92579
    
Checking UI and functionality of Pincode and Delivery Section
    Pincode Verification
    Confirm the functionality of Click here text              #Testcase: 92587

Checking Accordion Functionality
    Open All Accordions