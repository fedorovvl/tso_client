.class Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;
.super Landroid/content/BroadcastReceiver;
.source "HDMIUtils.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/flashplayer/HDMIUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "HdmiBroadcastReceiver"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/flashplayer/HDMIUtils;


# direct methods
.method constructor <init>(Lcom/adobe/flashplayer/HDMIUtils;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/flashplayer/HDMIUtils;

    .prologue
    .line 174
    iput-object p1, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 8
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "intent"    # Landroid/content/Intent;

    .prologue
    const/4 v6, 0x0

    const/4 v5, 0x1

    .line 179
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    .line 180
    .local v0, "action":Ljava/lang/String;
    if-eqz p2, :cond_1

    invoke-virtual {p2}, Landroid/content/Intent;->getExtras()Landroid/os/Bundle;

    move-result-object v2

    .line 184
    .local v2, "extras":Landroid/os/Bundle;
    :goto_0
    const-string v4, "com.motorola.intent.action.EXTDISP_STATUS_CONNECTION"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 187
    if-eqz v2, :cond_0

    .line 189
    const-string v4, "hdmi"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    .line 192
    .local v1, "conn":Z
    iget-object v4, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-static {v4}, Lcom/adobe/flashplayer/HDMIUtils;->access$000(Lcom/adobe/flashplayer/HDMIUtils;)Z

    move-result v4

    if-eq v1, v4, :cond_0

    .line 194
    iget-object v4, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-static {v4, v1}, Lcom/adobe/flashplayer/HDMIUtils;->access$002(Lcom/adobe/flashplayer/HDMIUtils;Z)Z

    .line 195
    iget-object v4, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-static {v4, v5}, Lcom/adobe/flashplayer/HDMIUtils;->access$102(Lcom/adobe/flashplayer/HDMIUtils;Z)Z

    .line 228
    .end local v1    # "conn":Z
    :cond_0
    :goto_1
    return-void

    .line 180
    .end local v2    # "extras":Landroid/os/Bundle;
    :cond_1
    const/4 v2, 0x0

    goto :goto_0

    .line 199
    .restart local v2    # "extras":Landroid/os/Bundle;
    :cond_2
    const-string v4, "com.motorola.intent.action.EXTDISP_STATUS_DISPLAY"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 202
    if-eqz v2, :cond_0

    .line 204
    const-string v4, "hdmi"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    .line 207
    .local v3, "on":Z
    iget-object v4, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-static {v4}, Lcom/adobe/flashplayer/HDMIUtils;->access$200(Lcom/adobe/flashplayer/HDMIUtils;)Z

    move-result v4

    if-eq v3, v4, :cond_0

    .line 209
    iget-object v4, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-static {v4, v3}, Lcom/adobe/flashplayer/HDMIUtils;->access$202(Lcom/adobe/flashplayer/HDMIUtils;Z)Z

    .line 210
    iget-object v4, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-static {v4, v5}, Lcom/adobe/flashplayer/HDMIUtils;->access$102(Lcom/adobe/flashplayer/HDMIUtils;Z)Z

    goto :goto_1

    .line 214
    .end local v3    # "on":Z
    :cond_3
    const-string v4, "com.motorola.intent.action.externaldisplaystate"

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 217
    if-eqz v2, :cond_0

    .line 219
    iget-object v7, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    const-string v4, "hdmi"

    invoke-virtual {v2, v4}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v4

    if-ne v4, v5, :cond_5

    move v4, v5

    :goto_2
    invoke-static {v7, v4}, Lcom/adobe/flashplayer/HDMIUtils;->access$202(Lcom/adobe/flashplayer/HDMIUtils;Z)Z

    .line 220
    iget-object v4, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    const-string v7, "hdcp"

    invoke-virtual {v2, v7}, Landroid/os/Bundle;->getInt(Ljava/lang/String;)I

    move-result v7

    if-ne v7, v5, :cond_4

    move v6, v5

    :cond_4
    invoke-static {v4, v6}, Lcom/adobe/flashplayer/HDMIUtils;->access$302(Lcom/adobe/flashplayer/HDMIUtils;Z)Z

    .line 225
    iget-object v4, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiBroadcastReceiver;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-static {v4, v5}, Lcom/adobe/flashplayer/HDMIUtils;->access$102(Lcom/adobe/flashplayer/HDMIUtils;Z)Z

    goto :goto_1

    :cond_5
    move v4, v6

    .line 219
    goto :goto_2
.end method
