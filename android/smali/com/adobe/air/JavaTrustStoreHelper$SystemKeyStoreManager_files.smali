.class Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;
.super Ljava/lang/Object;
.source "JavaTrustStoreHelper.java"

# interfaces
.implements Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/JavaTrustStoreHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SystemKeyStoreManager_files"
.end annotation


# static fields
.field private static final kDirectoryPath:Ljava/lang/String; = "/system/etc/security/cacerts"


# instance fields
.field private mNumFilesWhenCreated:I


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 132
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 135
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;->mNumFilesWhenCreated:I

    return-void
.end method

.method synthetic constructor <init>(Lcom/adobe/air/JavaTrustStoreHelper$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/adobe/air/JavaTrustStoreHelper$1;

    .prologue
    .line 132
    invoke-direct {p0}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;-><init>()V

    return-void
.end method

.method private static getFileListing()[Ljava/lang/String;
    .locals 3

    .prologue
    .line 164
    new-instance v0, Ljava/io/File;

    const-string v2, "/system/etc/security/cacerts"

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 165
    .local v0, "dir":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->list()[Ljava/lang/String;

    move-result-object v1

    .line 166
    .local v1, "files":[Ljava/lang/String;
    return-object v1
.end method

.method public static isValid()Z
    .locals 3

    .prologue
    .line 140
    new-instance v1, Ljava/io/File;

    const-string v2, "/system/etc/security/cacerts"

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v0

    .line 141
    .local v0, "exists":Z
    return v0
.end method


# virtual methods
.method public getKeyStore()Ljava/security/KeyStore;
    .locals 14

    .prologue
    const/4 v11, 0x0

    .line 171
    const/4 v8, 0x0

    .line 175
    .local v8, "keyStore":Ljava/security/KeyStore;
    :try_start_0
    invoke-static {}, Ljava/security/KeyStore;->getDefaultType()Ljava/lang/String;

    move-result-object v12

    invoke-static {v12}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v8

    .line 176
    const/4 v12, 0x0

    invoke-virtual {v8, v12}, Ljava/security/KeyStore;->load(Ljava/security/KeyStore$LoadStoreParameter;)V

    .line 178
    const-string v12, "X.509"

    invoke-static {v12}, Ljava/security/cert/CertificateFactory;->getInstance(Ljava/lang/String;)Ljava/security/cert/CertificateFactory;

    move-result-object v1

    .line 180
    .local v1, "certFactory":Ljava/security/cert/CertificateFactory;
    invoke-static {}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;->getFileListing()[Ljava/lang/String;

    move-result-object v5

    .line 181
    .local v5, "files":[Ljava/lang/String;
    array-length v12, v5

    iput v12, p0, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;->mNumFilesWhenCreated:I

    .line 184
    const/4 v7, 0x0

    .local v7, "i":I
    :goto_0
    array-length v12, v5

    if-ge v7, v12, :cond_0

    .line 186
    aget-object v3, v5, v7

    .line 187
    .local v3, "fileName":Ljava/lang/String;
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    const-string v13, "/system/etc/security/cacerts/"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v12

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 188
    .local v4, "filePath":Ljava/lang/String;
    new-instance v10, Ljava/io/File;

    invoke-direct {v10, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 189
    .local v10, "newFile":Ljava/io/File;
    new-instance v6, Ljava/io/FileInputStream;

    invoke-direct {v6, v10}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 190
    .local v6, "fis":Ljava/io/FileInputStream;
    invoke-virtual {v1, v6}, Ljava/security/cert/CertificateFactory;->generateCertificate(Ljava/io/InputStream;)Ljava/security/cert/Certificate;

    move-result-object v9

    .line 191
    .local v9, "newCert":Ljava/security/cert/Certificate;
    invoke-static {v7}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v0

    .line 193
    .local v0, "alias":Ljava/lang/String;
    invoke-virtual {v8, v0, v9}, Ljava/security/KeyStore;->setCertificateEntry(Ljava/lang/String;Ljava/security/cert/Certificate;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 184
    add-int/lit8 v7, v7, 0x1

    goto :goto_0

    .line 197
    .end local v0    # "alias":Ljava/lang/String;
    .end local v1    # "certFactory":Ljava/security/cert/CertificateFactory;
    .end local v3    # "fileName":Ljava/lang/String;
    .end local v4    # "filePath":Ljava/lang/String;
    .end local v5    # "files":[Ljava/lang/String;
    .end local v6    # "fis":Ljava/io/FileInputStream;
    .end local v7    # "i":I
    .end local v9    # "newCert":Ljava/security/cert/Certificate;
    .end local v10    # "newFile":Ljava/io/File;
    :catch_0
    move-exception v2

    .line 200
    .local v2, "e":Ljava/lang/Exception;
    const/4 v12, -0x1

    iput v12, p0, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;->mNumFilesWhenCreated:I

    .line 204
    .end local v2    # "e":Ljava/lang/Exception;
    :goto_1
    return-object v11

    .restart local v1    # "certFactory":Ljava/security/cert/CertificateFactory;
    .restart local v5    # "files":[Ljava/lang/String;
    .restart local v7    # "i":I
    :cond_0
    move-object v11, v8

    goto :goto_1
.end method

.method public getTimestamp()J
    .locals 10

    .prologue
    .line 146
    invoke-static {}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;->getFileListing()[Ljava/lang/String;

    move-result-object v1

    .line 147
    .local v1, "files":[Ljava/lang/String;
    iget v8, p0, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;->mNumFilesWhenCreated:I

    const/4 v9, -0x1

    if-eq v8, v9, :cond_1

    array-length v8, v1

    iget v9, p0, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;->mNumFilesWhenCreated:I

    if-eq v8, v9, :cond_1

    .line 148
    const-wide v6, 0x7fffffffffffffffL

    .line 159
    :cond_0
    return-wide v6

    .line 150
    :cond_1
    const-wide/16 v6, 0x0

    .line 151
    .local v6, "newestFileTime":J
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v8, v1

    if-ge v3, v8, :cond_0

    .line 153
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v9, "/system/etc/security/cacerts/"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    aget-object v9, v1, v3

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 154
    .local v2, "fullPath":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 155
    .local v0, "f":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    .line 156
    .local v4, "lastModified":J
    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v6

    .line 151
    add-int/lit8 v3, v3, 0x1

    goto :goto_0
.end method
