.class Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_stub;
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
    name = "SystemKeyStoreManager_stub"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 62
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/adobe/air/JavaTrustStoreHelper$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/adobe/air/JavaTrustStoreHelper$1;

    .prologue
    .line 62
    invoke-direct {p0}, Lcom/adobe/air/JavaTrustStoreHelper$SystemKeyStoreManager_stub;-><init>()V

    return-void
.end method


# virtual methods
.method public getKeyStore()Ljava/security/KeyStore;
    .locals 1

    .prologue
    .line 67
    const/4 v0, 0x0

    return-object v0
.end method

.method public getTimestamp()J
    .locals 2

    .prologue
    .line 73
    const-wide/16 v0, 0x0

    return-wide v0
.end method
