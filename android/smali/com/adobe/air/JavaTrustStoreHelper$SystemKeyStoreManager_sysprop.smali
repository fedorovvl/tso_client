.class Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_sysprop;
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
    name = "SystemKeyStoreManager_sysprop"
.end annotation


# static fields
.field private static final kTheProp:Ljava/lang/String; = "javax.net.ssl.trustStore"


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 79
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/adobe/air/JavaTrustStoreHelper$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/adobe/air/JavaTrustStoreHelper$1;

    .prologue
    .line 79
    invoke-direct {p0}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_sysprop;-><init>()V

    return-void
.end method

.method public static isValid()Z
    .locals 2

    .prologue
    .line 84
    const-string v1, "javax.net.ssl.trustStore"

    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 85
    .local v0, "propValue":Ljava/lang/String;
    if-eqz v0, :cond_0

    const/4 v1, 0x1

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method


# virtual methods
.method public getKeyStore()Ljava/security/KeyStore;
    .locals 7

    .prologue
    const/4 v5, 0x0

    .line 90
    const/4 v2, 0x0

    .line 94
    .local v2, "keyStore":Ljava/security/KeyStore;
    :try_start_0
    invoke-static {}, Ljava/security/KeyStore;->getDefaultType()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Ljava/security/KeyStore;->getInstance(Ljava/lang/String;)Ljava/security/KeyStore;

    move-result-object v2

    .line 96
    const-string v6, "javax.net.ssl.trustStore"

    invoke-static {v6}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 97
    .local v4, "theProp":Ljava/lang/String;
    if-nez v4, :cond_1

    .line 119
    .end local v4    # "theProp":Ljava/lang/String;
    :cond_0
    :goto_0
    return-object v5

    .line 103
    .restart local v4    # "theProp":Ljava/lang/String;
    :cond_1
    new-instance v3, Ljava/io/File;

    invoke-direct {v3, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 104
    .local v3, "newFile":Ljava/io/File;
    if-eqz v3, :cond_0

    .line 110
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, v3}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 111
    .local v1, "fis":Ljava/io/FileInputStream;
    const/4 v6, 0x0

    invoke-virtual {v2, v1, v6}, Ljava/security/KeyStore;->load(Ljava/io/InputStream;[C)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v5, v2

    .line 119
    goto :goto_0

    .line 113
    .end local v1    # "fis":Ljava/io/FileInputStream;
    .end local v3    # "newFile":Ljava/io/File;
    .end local v4    # "theProp":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 116
    .local v0, "e":Ljava/lang/Exception;
    goto :goto_0
.end method

.method public getTimestamp()J
    .locals 4

    .prologue
    .line 124
    const-string v2, "javax.net.ssl.trustStore"

    invoke-static {v2}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 125
    .local v1, "javaTrustStoreFileName":Ljava/lang/String;
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 126
    .local v0, "f":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->lastModified()J

    move-result-wide v2

    return-wide v2
.end method
