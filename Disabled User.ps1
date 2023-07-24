# LDAPパスを定義します。"YourDomainController"は適切なドメインコントローラのアドレスに置き換えてください。
$ldapPath = "LDAP://192.196.1.123"

# ユーザーに認証情報を入力させます。
$credential = Get-Credential

# DirectoryEntryオブジェクトを作成します。
$entry = New-Object System.DirectoryServices.DirectoryEntry($ldapPath, $credential.UserName, $credential.GetNetworkCredential().Password)

# DirectorySearcherオブジェクトを作成します。
$searcher = New-Object System.DirectoryServices.DirectorySearcher($entry)

# UserAccountControlの2ビット目が1の場合、アカウントは無効
$searcher.Filter = "(&(objectCategory=person)(objectClass=user)(userAccountControl:1.2.840.113556.1.4.803:=2))"

# 検索を実行し、結果を出力します。
$results = $searcher.FindAll()

foreach ($result in $results) {
    $userName = $result.Properties["samaccountname"]
    Write-Output $userName
}
