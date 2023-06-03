.class public Lcom/adobe/air/telephony/AndroidTelephonyManager;
.super Ljava/lang/Object;
.source "AndroidTelephonyManager.java"


# static fields
.field private static sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;


# instance fields
.field private mContext:Landroid/content/Context;

.field private mListening:Z

.field private mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

.field private mTelephonyMgr:Landroid/telephony/TelephonyManager;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 30
    const/4 v0, 0x0

    sput-object v0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    return-void
.end method

.method private constructor <init>(Landroid/content/Context;)V
    .locals 2
    .param p1, "c"    # Landroid/content/Context;

    .prologue
    const/4 v0, 0x0

    .line 49
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    iput-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mContext:Landroid/content/Context;

    .line 32
    iput-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    .line 33
    iput-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mTelephonyMgr:Landroid/telephony/TelephonyManager;

    .line 34
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mListening:Z

    .line 50
    iput-object p1, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mContext:Landroid/content/Context;

    .line 51
    iget-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mContext:Landroid/content/Context;

    if-eqz v0, :cond_0

    .line 52
    iget-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mContext:Landroid/content/Context;

    const-string v1, "phone"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    iput-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mTelephonyMgr:Landroid/telephony/TelephonyManager;

    .line 53
    :cond_0
    return-void
.end method

.method public static CreateAndroidTelephonyManager(Landroid/content/Context;)Lcom/adobe/air/telephony/AndroidTelephonyManager;
    .locals 1
    .param p0, "c"    # Landroid/content/Context;

    .prologue
    .line 38
    sget-object v0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    if-nez v0, :cond_0

    .line 39
    new-instance v0, Lcom/adobe/air/telephony/AndroidTelephonyManager;

    invoke-direct {v0, p0}, Lcom/adobe/air/telephony/AndroidTelephonyManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    .line 40
    :cond_0
    sget-object v0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    return-object v0
.end method

.method public static GetAndroidTelephonyManager()Lcom/adobe/air/telephony/AndroidTelephonyManager;
    .locals 1

    .prologue
    .line 45
    sget-object v0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->sAndroidTelephonyManager:Lcom/adobe/air/telephony/AndroidTelephonyManager;

    return-object v0
.end method


# virtual methods
.method public listen(Z)V
    .locals 3
    .param p1, "start"    # Z

    .prologue
    .line 59
    iget-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mTelephonyMgr:Landroid/telephony/TelephonyManager;

    if-nez v0, :cond_1

    .line 88
    :cond_0
    :goto_0
    return-void

    .line 63
    :cond_1
    if-eqz p1, :cond_3

    :try_start_0
    iget-boolean v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mListening:Z

    if-nez v0, :cond_3

    .line 65
    iget-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    if-nez v0, :cond_2

    .line 67
    new-instance v0, Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    invoke-direct {v0}, Lcom/adobe/air/telephony/AndroidPhoneStateListener;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    .line 69
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mTelephonyMgr:Landroid/telephony/TelephonyManager;

    iget-object v1, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    const/16 v2, 0x20

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    .line 70
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mListening:Z

    .line 74
    iget-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    iget-object v1, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mTelephonyMgr:Landroid/telephony/TelephonyManager;

    invoke-virtual {v1}, Landroid/telephony/TelephonyManager;->getCallState()I

    move-result v1

    const-string v2, "0"

    invoke-virtual {v0, v1, v2}, Lcom/adobe/air/telephony/AndroidPhoneStateListener;->onCallStateChanged(ILjava/lang/String;)V

    goto :goto_0

    .line 84
    :catch_0
    move-exception v0

    goto :goto_0

    .line 77
    :cond_3
    if-nez p1, :cond_0

    iget-boolean v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mListening:Z

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    if-eqz v0, :cond_0

    .line 79
    iget-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mTelephonyMgr:Landroid/telephony/TelephonyManager;

    iget-object v1, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/telephony/TelephonyManager;->listen(Landroid/telephony/PhoneStateListener;I)V

    .line 80
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mPhoneStateListener:Lcom/adobe/air/telephony/AndroidPhoneStateListener;

    .line 81
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/telephony/AndroidTelephonyManager;->mListening:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method
