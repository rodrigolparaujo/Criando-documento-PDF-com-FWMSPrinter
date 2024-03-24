#INCLUDE "PROTHEUS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPRINTSETUP.CH"

/*/{Protheus.doc} Exp0034
Gerar documento com Protheus
@type function
@author Rodrigo Araujo
@since 24/03/2024
/*/
User Function Exp0034()
	Local cDestino  := ""
    Local oReport
	Local oFont12   := TFont():New("Arial",,13,,.F.,,,,,.F.,.F.)
	Local oFont14   := TFont():New("Arial",,16,,.T.,,,,,.F.,.F.)

    If Aviso("Gerar documento com Protheus","Nese exemplo, irei gerar um arquivo em PDF usando FWMSPrinter.",{"Continuar","Fechar"},2) == 2
        Return
    Endif
    
		cDestino := tFileDialog( "", 'Selecione Pasta de Destino',, "C:\LocalData\Mesclar Aquivos\", .F.,  GETF_RETDIRECTORY  )
        cDestino := IIF(Right(cDestino,1)=="\", cDestino, cDestino + "\")

		If ExistDir(cDestino)
            //https://tdn.totvs.com.br/display/public/framework/FWMsPrinter
            oReport:= FWMSPrinter():New("Documento Gerado pelo Protheus.pdf",6, .f., cDestino, .t.,.T.,,,.T.,.F.,,.F.,1)		
            oReport:SetResolution(70)           //Resolução da impressão
            oReport:SetPortrait()               //Define a rotação do papel, se será retrato ou paisagem
            oReport:SetPaperSize( 9 )           //Define o formato A4
            oReport:SetMargin(10, 10, 10, 10)	//Margem de impressão
            oReport:nDevice := IMP_PDF          //Dispositivo que define que gerará o arquivo em PDF
            oReport:cPathPDF:= cDestino         //Destino onde será gravado o arquivo

            oReport:Say(100, 050, "Visão geral do Ghostscript", oFont14) 
            oReport:Say(120, 050, "Ghostscript é um intérprete para a linguagem PostScript® e arquivos PDF . Ele está disponível sob a licença GNU", oFont12) 
            oReport:Say(140, 050, "GPL Affero ou licenciado para uso comercial pela Artifex Software, Inc. Ele está em desenvolvimento ativo há", oFont12)
            oReport:Say(160, 050, "mais de 30 anos e foi portado para vários sistemas diferentes durante esse período.", oFont12) 
            oReport:Say(180, 050, "Ghostscript consiste em uma camada de interpretação PostScript e uma biblioteca gráfica.", oFont12) 
            //oReport:Print() //Apenas gera o arquivo
            oReport:SetViewPDF(.T.) 
			oReport:Preview() //Visualiza o arquivo gerado
	Endif
Return
