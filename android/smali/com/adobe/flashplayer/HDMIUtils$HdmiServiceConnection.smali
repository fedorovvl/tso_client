.class Lcom/adobe/flashplayer/HDMIUtils$HdmiServiceConnection;
.super Ljava/lang/Object;
.source "HDMIUtils.java"

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/flashplayer/HDMIUtils;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "HdmiServiceConnection"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/flashplayer/HDMIUtils;


# direct methods
.method constructor <init>(Lcom/adobe/flashplayer/HDMIUtils;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/flashplayer/HDMIUtils;

    .prologue
    .line 236
    iput-object p1, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiServiceConnection;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 0
    .param p1, "name"    # Landroid/content/ComponentName;
    .param p2, "service"    # Landroid/os/IBinder;

    .prologue
    .line 258
    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 2
    .param p1, "name"    # Landroid/content/ComponentName;

    .prologue
    .line 264
    iget-object v0, p0, Lcom/adobe/flashplayer/HDMIUtils$HdmiServiceConnection;->this$0:Lcom/adobe/flashplayer/HDMIUtils;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/adobe/flashplayer/HDMIUtils;->access$102(Lcom/adobe/flashplayer/HDMIUtils;Z)Z

    .line 265
    return-void
.end method
