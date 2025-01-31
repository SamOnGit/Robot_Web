*** Settings ***
Library  SeleniumLibrary


*** Keywords ***
# Podemos criar as nossas keywords, é como se fosse um bloco de codigo a ser executado
Acessar a aplicacao
    Open Browser  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login  chrome
    sleep  5
    Wait Until Element Is Enabled  xpath://input[@name="username"]
    Input Text  xpath://input[@name="username"]  ${Username} 
    Input Text  xpath://input[@name="password"]  admin123
    Click Element  xpath://button[text()=" Login "]
    sleep  5


*** Variables ***
${Username}  Admin                                           # Aqui é a zona de variaveis (esta é uma variavel simples)
${Password}  admin123                                     #
@{Dias_da_semana}  Dom  Seg  Ter  Qua  Qui  Sex  Sab  Dom        #Esta é uma variavel tipo array/Lista, para aceder à 1a posição (Dom) é @Dias_da_semana[0]
&{Cadastro}  nome=Samuel email=sam@gmail.com              #Dicionário: Esta é uma variavel par - valor



*** Test Cases ***
TESTE01 - Logar com user e password corretos
    [Tags]  Logar
    
    # Abrir a aplicação
        #[Tags]  Logar
        Open Browser  https://opensource-demo.orangehrmlive.com/web/index.php/auth/login  chrome

        #Abrir browser maximizado (com options)
        # Open Browser    https://opensource-demo.orangehrmlive.com/web/index.php/auth/login    chrome    options=add_argument("--start-maximized")

    # Inserir Logine senha
        
        sleep  5    # Usa-se este tempo para esperar que a pagina carregue e o elemento esteja disppon+ivel, senºao não vai encontrar
                    # Mas isso não é boa ideia porque pode carregar +rapido(e perdemos tempo...) ou +lento(e o elemento acaba por não ser encontrado)
        Wait Until Element Is Enabled  xpath://input[@name="username"]
        Input Text  xpath://input[@name="username"]  ${Username}    #Aqui uso a variável username já definida e assignada na secção acima *** Variables ***
        Input Text  xpath://input[@name="password"]  admin123


TESTE02 - Validar que não estou logado (antes de clicar em login)  # Faço este teste antes de clicar no botão de login
        Page Should Not Contain Element  xpath://img[@src="/web/images/orangehrm-logo.png?v=1721393199309"]
        

TESTE03 - Validar que estou logado   #Vou validar se a imagem da empresa está presente na pagina e assim valido que estou logado
    # clicar no OK
        # Não é a forma correta de encontrar o elemento atraves de uma classe...
        #Click Element  //button[@class="oxd-button oxd-button--medium oxd-button--main orangehrm-login-button"]

        # Assim fica melhor
        Click Element  xpath://button[text()=" Login "]

        # podia ser tambem:, mas não está a funcionar...
        # //button[contains(text()," Login ")]

        # podia ser tambem assim
        #Click Element  xpath://button[text()=" Login "]

        sleep  5

       Page Should Contain Image  //img[@src="/web/images/orangehrm-logo.png?v=1721393199309"]
        
       Capture Page Screenshot  #Captura ScreenShot e apresenta-o no log.html, é muito util !!

TESTE04 - Validar Clicks no menu lateral esquerdo
    Click Link  //a[@href="/web/index.php/admin/viewAdminModule"]
    sleep  2
    Element Should Be Visible  //h6[text()="User Management"]

    Click Link  //a[@href="/web/index.php/pim/viewPimModule"]
    sleep  2
    Element Should Be Visible  //h6[text()="PIM"]

TESTE05 - Validar Clicks no menu lateral esquerdo, usando keywords
    Acessar a aplicacao
    Click Link  //a[@href="/web/index.php/admin/viewAdminModule"]
    sleep  2
    Element Should Be Visible  //h6[text()="User Management"]

    Acessar a aplicacao
    Click Link  //a[@href="/web/index.php/pim/viewPimModule"]
    sleep  2
    Element Should Be Visible  //h6[text()="PIM"] 

Analisando Variaveis
    [Tags]  var
    Log To Console    \n Username=${Username}
    Log To Console    \n Password=${Password}  

    Log To Console    ${Dias_da_semana}[2]    #esta variavel array +e criada com @{Dias_da_semana}, mas é exibida atraves de ${nomevar}[2], ou seja indexada
   Log To Console     ${Cadastro.nome} 
    
    #Log To Console    @{Dias_da_semana}  &{Cadastro}



#