.class Lcom/adobe/air/ShakeListenerService$BackgroundThread;
.super Ljava/lang/Thread;
.source "ShakeListenerService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/adobe/air/ShakeListenerService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "BackgroundThread"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/ShakeListenerService;


# direct methods
.method public constructor <init>(Lcom/adobe/air/ShakeListenerService;Landroid/content/Context;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/ShakeListenerService;
    .param p2, "context"    # Landroid/content/Context;

    .prologue
    .line 71
    iput-object p1, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 72
    invoke-static {p1, p2}, Lcom/adobe/air/ShakeListenerService;->access$002(Lcom/adobe/air/ShakeListenerService;Landroid/content/Context;)Landroid/content/Context;

    .line 73
    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 79
    :try_start_0
    iget-object v1, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->this$0:Lcom/adobe/air/ShakeListenerService;

    new-instance v2, Lcom/adobe/air/ShakeListener;

    iget-object v3, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-static {v3}, Lcom/adobe/air/ShakeListenerService;->access$000(Lcom/adobe/air/ShakeListenerService;)Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/adobe/air/ShakeListener;-><init>(Landroid/content/Context;)V

    invoke-static {v1, v2}, Lcom/adobe/air/ShakeListenerService;->access$102(Lcom/adobe/air/ShakeListenerService;Lcom/adobe/air/ShakeListener;)Lcom/adobe/air/ShakeListener;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 87
    iget-object v1, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-static {v1}, Lcom/adobe/air/ShakeListenerService;->access$100(Lcom/adobe/air/ShakeListenerService;)Lcom/adobe/air/ShakeListener;

    move-result-object v1

    new-instance v2, Lcom/adobe/air/ShakeListenerService$BackgroundThread$1;

    invoke-direct {v2, p0}, Lcom/adobe/air/ShakeListenerService$BackgroundThread$1;-><init>(Lcom/adobe/air/ShakeListenerService$BackgroundThread;)V

    invoke-virtual {v1, v2}, Lcom/adobe/air/ShakeListener;->registerListener(Lcom/adobe/air/ShakeListener$Listener;)V

    .line 116
    :goto_0
    return-void

    .line 81
    :catch_0
    move-exception v0

    .line 84
    .local v0, "e":Ljava/lang/Exception;
    goto :goto_0
.end method
