.class public Lcom/adobe/air/AdobeAIR;
.super Landroid/app/Activity;
.source "AdobeAIR.java"


# static fields
.field private static final PROPERTY_INITIAL_LAUNCH:Ljava/lang/String; = "initialLaunch"

.field private static final TAG:Ljava/lang/String; = "Adobe AIR"


# instance fields
.field public DYNAMIC_URL:Ljava/lang/String;

.field private mCtx:Landroid/content/Context;

.field private mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 34
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 125
    iput-object v1, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    .line 126
    const-string v0, "https://www.adobe.com/airgames/5/"

    iput-object v0, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    .line 129
    iput-object v1, p0, Lcom/adobe/air/AdobeAIR;->mCtx:Landroid/content/Context;

    return-void
.end method

.method private isInitialLaunch()Z
    .locals 3

    .prologue
    .line 63
    invoke-virtual {p0}, Lcom/adobe/air/AdobeAIR;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    invoke-static {v1}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 64
    .local v0, "prefs":Landroid/content/SharedPreferences;
    const-string v1, "initialLaunch"

    const/4 v2, 0x1

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    return v1
.end method

.method private updateSharedPrefForInitialLaunch()V
    .locals 4

    .prologue
    .line 71
    invoke-virtual {p0}, Lcom/adobe/air/AdobeAIR;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    invoke-static {v2}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v1

    .line 72
    .local v1, "prefs":Landroid/content/SharedPreferences;
    invoke-interface {v1}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 73
    .local v0, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v2, "initialLaunch"

    const/4 v3, 0x0

    invoke-interface {v0, v2, v3}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 74
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 75
    return-void
.end method


# virtual methods
.method public onBackPressed()V
    .locals 6

    .prologue
    .line 95
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    .line 99
    .local v1, "currentapiVersion":I
    const/16 v5, 0xc

    if-lt v1, v5, :cond_1

    iget-object v5, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v5}, Lcom/adobe/air/AdobeAIRWebView;->canGoBack()Z

    move-result v5

    if-eqz v5, :cond_1

    .line 101
    const/4 v2, 0x1

    .line 102
    .local v2, "gotoPrevHistItem":Z
    iget-object v5, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v5}, Lcom/adobe/air/AdobeAIRWebView;->copyBackForwardList()Landroid/webkit/WebBackForwardList;

    move-result-object v3

    .line 103
    .local v3, "history":Landroid/webkit/WebBackForwardList;
    invoke-virtual {v3}, Landroid/webkit/WebBackForwardList;->getCurrentIndex()I

    move-result v0

    .line 104
    .local v0, "curIndex":I
    if-lez v0, :cond_0

    .line 106
    add-int/lit8 v5, v0, -0x1

    invoke-virtual {v3, v5}, Landroid/webkit/WebBackForwardList;->getItemAtIndex(I)Landroid/webkit/WebHistoryItem;

    move-result-object v5

    invoke-virtual {v5}, Landroid/webkit/WebHistoryItem;->getUrl()Ljava/lang/String;

    move-result-object v4

    .line 109
    .local v4, "prevHistItem":Ljava/lang/String;
    iget-object v5, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 110
    const/4 v2, 0x0

    .line 115
    .end local v4    # "prevHistItem":Ljava/lang/String;
    :cond_0
    if-eqz v2, :cond_1

    .line 117
    iget-object v5, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v5}, Lcom/adobe/air/AdobeAIRWebView;->goBack()V

    .line 122
    .end local v0    # "curIndex":I
    .end local v2    # "gotoPrevHistItem":Z
    .end local v3    # "history":Landroid/webkit/WebBackForwardList;
    :goto_0
    return-void

    .line 121
    :cond_1
    invoke-super {p0}, Landroid/app/Activity;->onBackPressed()V

    goto :goto_0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 41
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 44
    iput-object p0, p0, Lcom/adobe/air/AdobeAIR;->mCtx:Landroid/content/Context;

    .line 46
    invoke-direct {p0}, Lcom/adobe/air/AdobeAIR;->isInitialLaunch()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 48
    const-string v0, "https://www.adobe.com/airgames/4/"

    iput-object v0, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    .line 49
    invoke-direct {p0}, Lcom/adobe/air/AdobeAIR;->updateSharedPrefForInitialLaunch()V

    .line 52
    :cond_0
    new-instance v0, Lcom/adobe/air/AdobeAIRWebView;

    iget-object v1, p0, Lcom/adobe/air/AdobeAIR;->mCtx:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    .line 53
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v0}, Lcom/adobe/air/AdobeAIRWebView;->create()V

    .line 56
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    iget-object v1, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;->loadUrl(Ljava/lang/String;)V

    .line 58
    invoke-virtual {p0}, Lcom/adobe/air/AdobeAIR;->getIntent()Landroid/content/Intent;

    move-result-object v0

    invoke-virtual {p0, v0}, Lcom/adobe/air/AdobeAIR;->onNewIntent(Landroid/content/Intent;)V

    .line 59
    return-void
.end method

.method public onResume()V
    .locals 2

    .prologue
    .line 80
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 85
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    invoke-virtual {v0}, Lcom/adobe/air/AdobeAIRWebView;->isOffline()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 87
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;->setOffline(Z)V

    .line 88
    iget-object v0, p0, Lcom/adobe/air/AdobeAIR;->mGameListingWebView:Lcom/adobe/air/AdobeAIRWebView;

    iget-object v1, p0, Lcom/adobe/air/AdobeAIR;->DYNAMIC_URL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lcom/adobe/air/AdobeAIRWebView;->loadUrl(Ljava/lang/String;)V

    .line 90
    :cond_0
    return-void
.end method
