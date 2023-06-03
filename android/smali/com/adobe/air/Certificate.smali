.class public Lcom/adobe/air/Certificate;
.super Ljava/lang/Object;
.source "Certificate.java"


# instance fields
.field private final TAG:Ljava/lang/String;

.field private m_certificate:Landroid/net/http/SslCertificate;

.field private m_factory:Ljava/security/cert/CertificateFactory;

.field private m_issuedBy:Landroid/net/http/SslCertificate$DName;

.field private m_issuedTo:Landroid/net/http/SslCertificate$DName;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 86
    const-string v0, "AIRCertificateWarningDialog"

    iput-object v0, p0, Lcom/adobe/air/Certificate;->TAG:Ljava/lang/String;

    .line 13
    :try_start_0
    const-string v0, "X.509"

    invoke-static {v0}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/Certificate;->m_factory:Ljava/security/cert/CertificateFactory;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 18
    :goto_0
    return-void

    .line 14
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public constructor <init>(Landroid/net/http/SslCertificate;)V
    .locals 1
    .param p1, "sslCertificate"    # Landroid/net/http/SslCertificate;

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 86
    const-string v0, "AIRCertificateWarningDialog"

    iput-object v0, p0, Lcom/adobe/air/Certificate;->TAG:Ljava/lang/String;

    .line 22
    :try_start_0
    iput-object p1, p0, Lcom/adobe/air/Certificate;->m_certificate:Landroid/net/http/SslCertificate;

    .line 23
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_certificate:Landroid/net/http/SslCertificate;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate;->getIssuedBy()Landroid/net/http/SslCertificate$DName;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/Certificate;->m_issuedBy:Landroid/net/http/SslCertificate$DName;

    .line 24
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_certificate:Landroid/net/http/SslCertificate;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate;->getIssuedTo()Landroid/net/http/SslCertificate$DName;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/Certificate;->m_issuedTo:Landroid/net/http/SslCertificate$DName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 28
    :goto_0
    return-void

    .line 25
    :catch_0
    move-exception v0

    goto :goto_0
.end method


# virtual methods
.method public getExpiresOn()Ljava/lang/String;
    .locals 1

    .prologue
    .line 77
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_certificate:Landroid/net/http/SslCertificate;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate;->getValidNotAfter()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedByCommonName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 61
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_issuedBy:Landroid/net/http/SslCertificate$DName;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate$DName;->getCName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedByOrganization()Ljava/lang/String;
    .locals 1

    .prologue
    .line 65
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_issuedBy:Landroid/net/http/SslCertificate$DName;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate$DName;->getOName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedByOrganizationalUnit()Ljava/lang/String;
    .locals 1

    .prologue
    .line 69
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_issuedBy:Landroid/net/http/SslCertificate$DName;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate$DName;->getUName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedOn()Ljava/lang/String;
    .locals 1

    .prologue
    .line 73
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_certificate:Landroid/net/http/SslCertificate;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate;->getValidNotBefore()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedToCommonName()Ljava/lang/String;
    .locals 1

    .prologue
    .line 50
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_issuedTo:Landroid/net/http/SslCertificate$DName;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate$DName;->getCName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedToOrganization()Ljava/lang/String;
    .locals 1

    .prologue
    .line 53
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_issuedTo:Landroid/net/http/SslCertificate$DName;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate$DName;->getOName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getIssuedToOrganizationalUnit()Ljava/lang/String;
    .locals 1

    .prologue
    .line 57
    iget-object v0, p0, Lcom/adobe/air/Certificate;->m_issuedTo:Landroid/net/http/SslCertificate$DName;

    invoke-virtual {v0}, Landroid/net/http/SslCertificate$DName;->getUName()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public setCertificate([B)Ljava/lang/Boolean;
    .locals 5
    .param p1, "cert"    # [B

    .prologue
    const/4 v4, 0x0

    .line 31
    iget-object v3, p0, Lcom/adobe/air/Certificate;->m_factory:Ljava/security/cert/CertificateFactory;

    if-nez v3, :cond_0

    .line 33
    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    .line 46
    :goto_0
    return-object v3

    .line 37
    :cond_0
    :try_start_0
    new-instance v1, Ljava/io/ByteArrayInputStream;

    invoke-direct {v1, p1}, Ljava/io/ByteArrayInputStream;-><init>([B)V

    .line 38
    .local v1, "stream":Ljava/io/ByteArrayInputStream;
    iget-object v3, p0, Lcom/adobe/air/Certificate;->m_factory:Ljava/security/cert/CertificateFactory;

    invoke-virtual {v3, v1}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v2

    check-cast v2, Ljava/security/cert/X509Certificate;

    .line 39
    .local v2, "x509certificate":Ljava/security/cert/X509Certificate;
    new-instance v3, Landroid/net/http/SslCertificate;

    invoke-direct {v3, v2}, Landroid/net/http/SslCertificate;-><init>(Ljava/security/cert/X509Certificate;)V

    iput-object v3, p0, Lcom/adobe/air/Certificate;->m_certificate:Landroid/net/http/SslCertificate;

    .line 40
    iget-object v3, p0, Lcom/adobe/air/Certificate;->m_certificate:Landroid/net/http/SslCertificate;

    invoke-virtual {v3}, Landroid/net/http/SslCertificate;->getIssuedBy()Landroid/net/http/SslCertificate$DName;

    move-result-object v3

    iput-object v3, p0, Lcom/adobe/air/Certificate;->m_issuedBy:Landroid/net/http/SslCertificate$DName;

    .line 41
    iget-object v3, p0, Lcom/adobe/air/Certificate;->m_certificate:Landroid/net/http/SslCertificate;

    invoke-virtual {v3}, Landroid/net/http/SslCertificate;->getIssuedTo()Landroid/net/http/SslCertificate$DName;

    move-result-object v3

    iput-object v3, p0, Lcom/adobe/air/Certificate;->m_issuedTo:Landroid/net/http/SslCertificate$DName;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 46
    const/4 v3, 0x1

    invoke-static {v3}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    goto :goto_0

    .line 42
    .end local v1    # "stream":Ljava/io/ByteArrayInputStream;
    .end local v2    # "x509certificate":Ljava/security/cert/X509Certificate;
    :catch_0
    move-exception v0

    .line 44
    .local v0, "e":Ljava/lang/Exception;
    invoke-static {v4}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v3

    goto :goto_0
.end method
