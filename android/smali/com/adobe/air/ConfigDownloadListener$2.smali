.class Lcom/adobe/air/ConfigDownloadListener$2;
.super Ljava/lang/Object;
.source "ConfigDownloadListener.java"

# interfaces
.implements Lcom/adobe/air/AndroidActivityWrapper$StateChangeCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/ConfigDownloadListener;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/ConfigDownloadListener;


# direct methods
.method constructor <init>(Lcom/adobe/air/ConfigDownloadListener;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/ConfigDownloadListener;

    .prologue
    .line 95
    iput-object p1, p0, Lcom/adobe/air/ConfigDownloadListener$2;->this$0:Lcom/adobe/air/ConfigDownloadListener;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onActivityStateChanged(Lcom/adobe/air/AndroidActivityWrapper$ActivityState;)V
    .locals 4
    .param p1, "state"    # Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    .prologue
    .line 103
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v0

    .line 104
    .local v0, "act":Landroid/app/Activity;
    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->PAUSED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-ne p1, v1, :cond_1

    .line 106
    iget-object v1, p0, Lcom/adobe/air/ConfigDownloadListener$2;->this$0:Lcom/adobe/air/ConfigDownloadListener;

    invoke-static {v1}, Lcom/adobe/air/ConfigDownloadListener;->access$100(Lcom/adobe/air/ConfigDownloadListener;)Landroid/content/BroadcastReceiver;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/Activity;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    .line 107
    iget-object v1, p0, Lcom/adobe/air/ConfigDownloadListener$2;->this$0:Lcom/adobe/air/ConfigDownloadListener;

    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    invoke-static {v1, v2, v3}, Lcom/adobe/air/ConfigDownloadListener;->access$002(Lcom/adobe/air/ConfigDownloadListener;J)J

    .line 112
    :cond_0
    :goto_0
    return-void

    .line 108
    :cond_1
    sget-object v1, Lcom/adobe/air/AndroidActivityWrapper$ActivityState;->RESUMED:Lcom/adobe/air/AndroidActivityWrapper$ActivityState;

    if-ne p1, v1, :cond_0

    .line 110
    iget-object v1, p0, Lcom/adobe/air/ConfigDownloadListener$2;->this$0:Lcom/adobe/air/ConfigDownloadListener;

    invoke-static {v1}, Lcom/adobe/air/ConfigDownloadListener;->access$100(Lcom/adobe/air/ConfigDownloadListener;)Landroid/content/BroadcastReceiver;

    move-result-object v1

    new-instance v2, Landroid/content/IntentFilter;

    const-string v3, "com.adobe.air.DownloadConfigComplete"

    invoke-direct {v2, v3}, Landroid/content/IntentFilter;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/Activity;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;

    goto :goto_0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "config"    # Landroid/content/res/Configuration;

    .prologue
    .line 116
    return-void
.end method
