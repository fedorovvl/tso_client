.class public final Lcom/adobe/air/JavaTrustStoreHelper;
.super Ljava/lang/Object;
.source "JavaTrustStoreHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;,
        Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_sysprop;,
        Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_stub;,
        Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;
    }
.end annotation


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "JavaTrustStoreHelper"

.field private static mSystemKeyStoreMgr:Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 52
    invoke-static {}, Lcom/adobe/air/JavaTrustStoreHelper;->initSystemKeyStoreMgr()Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;

    move-result-object v0

    sput-object v0, Lcom/adobe/air/JavaTrustStoreHelper;->mSystemKeyStoreMgr:Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static copyTimestamp(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p0, "src"    # Ljava/lang/String;
    .param p1, "dst"    # Ljava/lang/String;

    .prologue
    .line 304
    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 305
    .local v1, "s":Ljava/io/File;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 306
    .local v0, "d":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->lastModified()J

    move-result-wide v2

    invoke-virtual {v0, v2, v3}, Ljava/io/File;->setLastModified(J)Z
    :try_end_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_0

    .line 314
    .end local v0    # "d":Ljava/io/File;
    .end local v1    # "s":Ljava/io/File;
    :goto_0
    return-void

    .line 310
    :catch_0
    move-exception v2

    goto :goto_0

    .line 307
    :catch_1
    move-exception v2

    goto :goto_0
.end method

.method private static dumpAcceptedIssuersToFile(Ljavax/net/ssl/X509TrustManager;Ljava/io/RandomAccessFile;)I
    .locals 4
    .param p0, "tm"    # Ljavax/net/ssl/X509TrustManager;
    .param p1, "f"    # Ljava/io/RandomAccessFile;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/security/cert/CertificateEncodingException;,
            Ljava/io/IOException;,
            Ljava/io/SyncFailedException;
        }
    .end annotation

    .prologue
    .line 318
    invoke-interface {p0}, Ljavax/net/ssl/X509TrustManager;->getAcceptedIssuers()[Ljava/security/cert/X509Certificate;

    move-result-object v0

    .line 320
    .local v0, "caCert":[Ljava/security/cert/X509Certificate;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_0

    .line 324
    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/security/cert/X509Certificate;->getEncoded()[B

    move-result-object v1

    .line 325
    .local v1, "certBuffer":[B
    array-length v3, v1

    invoke-virtual {p1, v3}, Ljava/io/RandomAccessFile;->writeInt(I)V

    .line 326
    invoke-virtual {p1, v1}, Ljava/io/RandomAccessFile;->write([B)V

    .line 320
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 329
    .end local v1    # "certBuffer":[B
    :cond_0
    invoke-virtual {p1}, Ljava/io/RandomAccessFile;->getFD()Ljava/io/FileDescriptor;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/FileDescriptor;->sync()V

    .line 330
    array-length v3, v0

    return v3
.end method

.method public static enumerateRootCAs(Ljava/lang/String;Ljava/lang/String;)Z
    .locals 8
    .param p0, "airCertBundleFile"    # Ljava/lang/String;
    .param p1, "tempFileForJava"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x0

    .line 351
    const/4 v2, 0x0

    .line 352
    .local v2, "rv":Z
    const/4 v4, 0x0

    .line 354
    .local v4, "tm":Ljavax/net/ssl/X509TrustManager;
    invoke-static {p0}, Lcom/adobe/air/JavaTrustStoreHelper;->isAirCertBundleStale(Ljava/lang/String;)Z

    move-result v6

    if-nez v6, :cond_1

    .line 397
    :cond_0
    :goto_0
    return v5

    .line 359
    :cond_1
    invoke-static {}, Lcom/adobe/air/JavaTrustStoreHelper;->getX509TrustManager()Ljavax/net/ssl/X509TrustManager;

    move-result-object v4

    if-eqz v4, :cond_0

    .line 367
    :try_start_0
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 368
    .local v3, "tempFile":Ljava/io/File;
    new-instance v1, Ljava/io/RandomAccessFile;

    const-string v5, "rw"

    invoke-direct {v1, v3, v5}, Ljava/io/RandomAccessFile;-><init>(Ljava/io/File;Ljava/lang/String;)V

    .line 371
    .local v1, "rndAccessFile":Ljava/io/RandomAccessFile;
    const-wide/16 v6, 0x0

    invoke-virtual {v1, v6, v7}, Ljava/io/RandomAccessFile;->setLength(J)V

    .line 373
    invoke-static {v4, v1}, Lcom/adobe/air/JavaTrustStoreHelper;->dumpAcceptedIssuersToFile(Ljavax/net/ssl/X509TrustManager;Ljava/io/RandomAccessFile;)I

    move-result v0

    .line 377
    .local v0, "numCerts":I
    invoke-static {}, Lcom/adobe/air/JavaTrustStoreHelper;->getTrustStoreTimestamp()J

    move-result-wide v6

    invoke-virtual {v3, v6, v7}, Ljava/io/File;->setLastModified(J)Z

    .line 378
    invoke-virtual {v1}, Ljava/io/RandomAccessFile;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_4
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/security/cert/CertificateEncodingException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0

    .line 379
    const/4 v2, 0x1

    .end local v0    # "numCerts":I
    .end local v1    # "rndAccessFile":Ljava/io/RandomAccessFile;
    .end local v3    # "tempFile":Ljava/io/File;
    :goto_1
    move v5, v2

    .line 397
    goto :goto_0

    .line 392
    :catch_0
    move-exception v5

    goto :goto_1

    .line 389
    :catch_1
    move-exception v5

    goto :goto_1

    .line 386
    :catch_2
    move-exception v5

    goto :goto_1

    .line 383
    :catch_3
    move-exception v5

    goto :goto_1

    .line 380
    :catch_4
    move-exception v5

    goto :goto_1
.end method

.method private static getTrustStoreTimestamp()J
    .locals 2

    .prologue
    .line 248
    sget-object v0, Lcom/adobe/air/JavaTrustStoreHelper;->mSystemKeyStoreMgr:Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;

    invoke-interface {v0}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;->getTimestamp()J

    move-result-wide v0

    return-wide v0
.end method

.method private static getX509TrustManager()Ljavax/net/ssl/X509TrustManager;
    .locals 5

    .prologue
    .line 274
    invoke-static {}, Lcom/adobe/air/JavaTrustStoreHelper;->getX509TrustManagerFactory()Ljavax/net/ssl/TrustManagerFactory;

    move-result-object v2

    .line 275
    .local v2, "tmf":Ljavax/net/ssl/TrustManagerFactory;
    const/4 v3, 0x0

    .line 277
    .local v3, "x509TM":Ljavax/net/ssl/X509TrustManager;
    if-eqz v2, :cond_0

    .line 279
    invoke-virtual {v2}, Ljavax/net/ssl/TrustManagerFactory;->getTrustManagers()[Ljavax/net/ssl/TrustManager;

    move-result-object v1

    .line 281
    .local v1, "systemTMs":[Ljavax/net/ssl/TrustManager;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v4, v1

    if-ge v0, v4, :cond_0

    .line 283
    aget-object v4, v1, v0

    instance-of v4, v4, Ljavax/net/ssl/X509TrustManager;

    if-eqz v4, :cond_1

    .line 285
    aget-object v3, v1, v0

    .end local v3    # "x509TM":Ljavax/net/ssl/X509TrustManager;
    check-cast v3, Ljavax/net/ssl/X509TrustManager;

    .line 292
    .end local v0    # "i":I
    .end local v1    # "systemTMs":[Ljavax/net/ssl/TrustManager;
    .restart local v3    # "x509TM":Ljavax/net/ssl/X509TrustManager;
    :cond_0
    return-object v3

    .line 281
    .restart local v0    # "i":I
    .restart local v1    # "systemTMs":[Ljavax/net/ssl/TrustManager;
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0
.end method

.method private static getX509TrustManagerFactory()Ljavax/net/ssl/TrustManagerFactory;
    .locals 4

    .prologue
    .line 253
    const/4 v2, 0x0

    .line 257
    .local v2, "tmf":Ljavax/net/ssl/TrustManagerFactory;
    :try_start_0
    const-string v3, "X509"

    invoke-static {v3}, Ljavax/net/ssl/TrustManagerFactory;->getInstance(Ljava/lang/String;)Ljavax/net/ssl/TrustManagerFactory;

    move-result-object v2

    .line 259
    sget-object v3, Lcom/adobe/air/JavaTrustStoreHelper;->mSystemKeyStoreMgr:Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;

    invoke-interface {v3}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;->getKeyStore()Ljava/security/KeyStore;

    move-result-object v1

    .line 261
    .local v1, "kStore":Ljava/security/KeyStore;
    invoke-virtual {v2, v1}, Ljavax/net/ssl/TrustManagerFactory;->init(Ljava/security/KeyStore;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 269
    .end local v1    # "kStore":Ljava/security/KeyStore;
    :goto_0
    return-object v2

    .line 263
    :catch_0
    move-exception v0

    .line 266
    .local v0, "e":Ljava/lang/Exception;
    const/4 v2, 0x0

    goto :goto_0
.end method

.method private static initSystemKeyStoreMgr()Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 228
    invoke-static {}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_sysprop;->isValid()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 232
    new-instance v0, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_sysprop;

    invoke-direct {v0, v1}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_sysprop;-><init>(Lcom/adobe/air/JavaTrustStoreHelper$1;)V

    .line 242
    :goto_0
    return-object v0

    .line 234
    :cond_0
    invoke-static {}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;->isValid()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 237
    new-instance v0, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;

    invoke-direct {v0, v1}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_files;-><init>(Lcom/adobe/air/JavaTrustStoreHelper$1;)V

    goto :goto_0

    .line 242
    :cond_1
    new-instance v0, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_stub;

    invoke-direct {v0, v1}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_stub;-><init>(Lcom/adobe/air/JavaTrustStoreHelper$1;)V

    goto :goto_0
.end method

.method private static isAirCertBundleStale(Ljava/lang/String;)Z
    .locals 6
    .param p0, "airCertBundleName"    # Ljava/lang/String;

    .prologue
    .line 214
    const/4 v1, 0x1

    .line 215
    .local v1, "stale":Z
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 217
    .local v0, "airCertBundle":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 219
    sget-object v2, Lcom/adobe/air/JavaTrustStoreHelper;->mSystemKeyStoreMgr:Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;

    invoke-interface {v2}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager;->getTimestamp()J

    move-result-wide v2

    invoke-virtual {v0}, Ljava/io/File;->lastModified()J

    move-result-wide v4

    cmp-long v2, v2, v4

    if-lez v2, :cond_1

    const/4 v1, 0x1

    .line 223
    :cond_0
    :goto_0
    return v1

    .line 219
    :cond_1
    const/4 v1, 0x0

    goto :goto_0
.end method
