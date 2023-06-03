.class Lcom/adobe/air/ConfigDownloadListener$1;
.super Landroid/content/BroadcastReceiver;
.source "ConfigDownloadListener.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/ConfigDownloadListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field private LOG_TAG:Ljava/lang/String;

.field final synthetic this$0:Lcom/adobe/air/ConfigDownloadListener;


# direct methods
.method constructor <init>(Lcom/adobe/air/ConfigDownloadListener;)V
    .locals 1
    .param p1, "this$0"    # Lcom/adobe/air/ConfigDownloadListener;

    .prologue
    .line 45
    iput-object p1, p0, Lcom/adobe/air/ConfigDownloadListener$1;->this$0:Lcom/adobe/air/ConfigDownloadListener;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    .line 46
    const-string v0, "ConfigDownloadListenerBR"

    iput-object v0, p0, Lcom/adobe/air/ConfigDownloadListener$1;->LOG_TAG:Ljava/lang/String;

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    .line 58
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v5

    const-string v6, "com.adobe.air.DownloadConfigComplete"

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 60
    const/4 v1, 0x0

    .line 61
    .local v1, "applyConfig":Z
    invoke-virtual {p0}, Lcom/adobe/air/ConfigDownloadListener$1;->isInitialStickyBroadcast()Z

    move-result v5

    if-eqz v5, :cond_2

    .line 63
    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v4

    .line 64
    .local v4, "extras":Landroid/os/Bundle;
    if-eqz v4, :cond_0

    .line 68
    const-string v5, "com.adobe.air.DownloadConfigCompleteTime"

    invoke-virtual {v4, v5}, Landroid/os/Bundle;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    .line 70
    .local v2, "downloadTime":J
    iget-object v5, p0, Lcom/adobe/air/ConfigDownloadListener$1;->this$0:Lcom/adobe/air/ConfigDownloadListener;

    invoke-static {v5}, Lcom/adobe/air/ConfigDownloadListener;->access$000(Lcom/adobe/air/ConfigDownloadListener;)J

    move-result-wide v6

    cmp-long v5, v6, v2

    if-gez v5, :cond_0

    .line 72
    const/4 v1, 0x1

    .line 81
    .end local v2    # "downloadTime":J
    .end local v4    # "extras":Landroid/os/Bundle;
    :cond_0
    :goto_0
    if-eqz v1, :cond_1

    .line 84
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    .line 85
    .local v0, "actWrap":Lcom/adobe/air/AndroidActivityWrapper;
    if-eqz v0, :cond_1

    .line 87
    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->applyDownloadedConfig()V

    .line 91
    .end local v0    # "actWrap":Lcom/adobe/air/AndroidActivityWrapper;
    .end local v1    # "applyConfig":Z
    :cond_1
    return-void

    .line 78
    .restart local v1    # "applyConfig":Z
    :cond_2
    const/4 v1, 0x1

    goto :goto_0
.end method
