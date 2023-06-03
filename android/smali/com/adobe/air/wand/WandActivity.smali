.class public Lcom/adobe/air/wand/WandActivity;
.super Landroid/app/Activity;
.source "WandActivity.java"


# static fields
.field private static final LOG_TAG:Ljava/lang/String; = "WandActivity"


# instance fields
.field private mHasResumed:Z

.field private mWandManager:Lcom/adobe/air/wand/WandManager;

.field private mWandWebSocket:Lcom/adobe/air/wand/connection/WandWebSocket;


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 37
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 45
    iput-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandWebSocket:Lcom/adobe/air/wand/connection/WandWebSocket;

    .line 51
    iput-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    .line 56
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/adobe/air/wand/WandActivity;->mHasResumed:Z

    return-void
.end method

.method private initialize()V
    .locals 3

    .prologue
    .line 77
    :try_start_0
    new-instance v1, Lcom/adobe/air/wand/connection/WandWebSocket;

    invoke-direct {v1, p0}, Lcom/adobe/air/wand/connection/WandWebSocket;-><init>(Landroid/app/Activity;)V

    iput-object v1, p0, Lcom/adobe/air/wand/WandActivity;->mWandWebSocket:Lcom/adobe/air/wand/connection/WandWebSocket;

    .line 79
    sget v1, Lcom/adobe/air/R$id;->wandView:I

    invoke-virtual {p0, v1}, Lcom/adobe/air/wand/WandActivity;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Lcom/adobe/air/wand/view/WandView;

    .line 84
    .local v0, "wandView":Lcom/adobe/air/wand/view/WandView;
    new-instance v1, Lcom/adobe/air/wand/WandManager;

    iget-object v2, p0, Lcom/adobe/air/wand/WandActivity;->mWandWebSocket:Lcom/adobe/air/wand/connection/WandWebSocket;

    invoke-direct {v1, p0, v0, v2}, Lcom/adobe/air/wand/WandManager;-><init>(Landroid/app/Activity;Lcom/adobe/air/wand/view/WandView;Lcom/adobe/air/wand/connection/Connection;)V

    iput-object v1, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 90
    .end local v0    # "wandView":Lcom/adobe/air/wand/view/WandView;
    :goto_0
    return-void

    .line 86
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method private terminate()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .prologue
    const/4 v1, 0x0

    .line 183
    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    invoke-virtual {v0}, Lcom/adobe/air/wand/WandManager;->dispose()V

    .line 184
    iput-object v1, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    .line 186
    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandWebSocket:Lcom/adobe/air/wand/connection/WandWebSocket;

    invoke-virtual {v0}, Lcom/adobe/air/wand/connection/WandWebSocket;->dispose()V

    .line 187
    iput-object v1, p0, Lcom/adobe/air/wand/WandActivity;->mWandWebSocket:Lcom/adobe/air/wand/connection/WandWebSocket;

    .line 188
    return-void
.end method


# virtual methods
.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 1
    .param p1, "config"    # Landroid/content/res/Configuration;

    .prologue
    .line 167
    invoke-super {p0, p1}, Landroid/app/Activity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 169
    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    invoke-virtual {v0}, Lcom/adobe/air/wand/WandManager;->hasFocus()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 172
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    invoke-virtual {v0, p1}, Lcom/adobe/air/wand/WandManager;->onConfigurationChanged(Landroid/content/res/Configuration;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 179
    :cond_0
    :goto_0
    return-void

    .line 174
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 2
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 60
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 62
    invoke-virtual {p0}, Lcom/adobe/air/wand/WandActivity;->getWindow()Landroid/view/Window;

    move-result-object v0

    .line 63
    .local v0, "window":Landroid/view/Window;
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Landroid/view/Window;->setFormat(I)V

    .line 69
    sget v1, Lcom/adobe/air/R$layout;->wand_main:I

    invoke-virtual {p0, v1}, Lcom/adobe/air/wand/WandActivity;->setContentView(I)V

    .line 71
    invoke-direct {p0}, Lcom/adobe/air/wand/WandActivity;->initialize()V

    .line 72
    return-void
.end method

.method public onDestroy()V
    .locals 1

    .prologue
    .line 149
    invoke-super {p0}, Landroid/app/Activity;->onDestroy()V

    .line 158
    :try_start_0
    invoke-direct {p0}, Lcom/adobe/air/wand/WandActivity;->terminate()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 163
    :goto_0
    return-void

    .line 160
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onPause()V
    .locals 2

    .prologue
    .line 130
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 133
    const/4 v0, 0x0

    :try_start_0
    iput-boolean v0, p0, Lcom/adobe/air/wand/WandActivity;->mHasResumed:Z

    .line 140
    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/adobe/air/wand/WandManager;->focus(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 145
    :goto_0
    return-void

    .line 142
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 94
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 96
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/adobe/air/wand/WandActivity;->mHasResumed:Z

    .line 97
    return-void
.end method

.method public onWindowFocusChanged(Z)V
    .locals 2
    .param p1, "hasFocus"    # Z

    .prologue
    .line 107
    invoke-super {p0, p1}, Landroid/app/Activity;->onWindowFocusChanged(Z)V

    .line 111
    iget-boolean v0, p0, Lcom/adobe/air/wand/WandActivity;->mHasResumed:Z

    if-eqz v0, :cond_0

    if-eqz p1, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    invoke-virtual {v0}, Lcom/adobe/air/wand/WandManager;->hasFocus()Z

    move-result v0

    if-nez v0, :cond_0

    .line 119
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/wand/WandActivity;->mWandManager:Lcom/adobe/air/wand/WandManager;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/adobe/air/wand/WandManager;->focus(Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 126
    :cond_0
    :goto_0
    return-void

    .line 121
    :catch_0
    move-exception v0

    goto :goto_0
.end method
