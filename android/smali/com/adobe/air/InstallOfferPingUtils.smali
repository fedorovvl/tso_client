.class public Lcom/adobe/air/InstallOfferPingUtils;
.super Ljava/lang/Object;
.source "InstallOfferPingUtils.java"


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "InstallOfferPingUtils"


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static PingAndExit(Landroid/app/Activity;Ljava/lang/String;ZZZ)V
    .locals 0
    .param p0, "activity"    # Landroid/app/Activity;
    .param p1, "baseUrl"    # Ljava/lang/String;
    .param p2, "installClicked"    # Z
    .param p3, "update"    # Z
    .param p4, "exit"    # Z

    .prologue
    .line 52
    return-void
.end method

.method private static isAndroidTV(Landroid/app/Activity;)Z
    .locals 5
    .param p0, "activity"    # Landroid/app/Activity;

    .prologue
    const/4 v2, 0x0

    .line 39
    :try_start_0
    const-string v3, "uimode"

    invoke-virtual {p0, v3}, Landroid/app/Activity;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/UiModeManager;

    .line 40
    .local v1, "uiModeManager":Landroid/app/UiModeManager;
    invoke-virtual {v1}, Landroid/app/UiModeManager;->getCurrentModeType()I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-result v3

    const/4 v4, 0x4

    if-ne v3, v4, :cond_0

    .line 41
    const/4 v2, 0x1

    .line 47
    .end local v1    # "uiModeManager":Landroid/app/UiModeManager;
    :cond_0
    :goto_0
    return v2

    .line 45
    :catch_0
    move-exception v0

    .line 47
    .local v0, "e":Ljava/lang/Exception;
    goto :goto_0
.end method
