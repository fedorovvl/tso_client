.class Lcom/adobe/air/ShakeListenerService$BackgroundThread$1;
.super Ljava/lang/Object;
.source "ShakeListenerService.java"

# interfaces
.implements Lcom/adobe/air/ShakeListener$Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/ShakeListenerService$BackgroundThread;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/adobe/air/ShakeListenerService$BackgroundThread;


# direct methods
.method constructor <init>(Lcom/adobe/air/ShakeListenerService$BackgroundThread;)V
    .locals 0
    .param p1, "this$1"    # Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    .prologue
    .line 88
    iput-object p1, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread$1;->this$1:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onShake()V
    .locals 6

    .prologue
    .line 93
    iget-object v4, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread$1;->this$1:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    iget-object v4, v4, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-virtual {v4}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    const-string v5, "activity"

    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 94
    .local v0, "mgr":Landroid/app/ActivityManager;
    const/4 v4, 0x1

    invoke-virtual {v0, v4}, Landroid/app/ActivityManager;->getRunningTasks(I)Ljava/util/List;

    move-result-object v1

    .line 95
    .local v1, "tasks":Ljava/util/List;, "Ljava/util/List<Landroid/app/ActivityManager$RunningTaskInfo;>;"
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v4

    if-nez v4, :cond_0

    .line 97
    const/4 v4, 0x0

    invoke-interface {v1, v4}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/app/ActivityManager$RunningTaskInfo;

    iget-object v2, v4, Landroid/app/ActivityManager$RunningTaskInfo;->topActivity:Landroid/content/ComponentName;

    .line 101
    .local v2, "topActivity":Landroid/content/ComponentName;
    invoke-virtual {v2}, Landroid/content/ComponentName;->getPackageName()Ljava/lang/String;

    move-result-object v4

    iget-object v5, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread$1;->this$1:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    iget-object v5, v5, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-virtual {v5}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    invoke-virtual {v5}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 103
    invoke-virtual {v2}, Landroid/content/ComponentName;->getClassName()Ljava/lang/String;

    move-result-object v4

    const-string v5, "com.adobe.air.wand.WandActivity"

    invoke-virtual {v4, v5}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_0

    .line 105
    new-instance v3, Landroid/content/Intent;

    iget-object v4, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread$1;->this$1:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    iget-object v4, v4, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-virtual {v4}, Lcom/adobe/air/ShakeListenerService;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    const-class v5, Lcom/adobe/air/wand/WandActivity;

    invoke-direct {v3, v4, v5}, Landroid/content/Intent;-><init>(Landroid/content/Context;Ljava/lang/Class;)V

    .line 107
    .local v3, "wandIntent":Landroid/content/Intent;
    const/high16 v4, 0x10400000

    invoke-virtual {v3, v4}, Landroid/content/Intent;->setFlags(I)Landroid/content/Intent;

    .line 108
    iget-object v4, p0, Lcom/adobe/air/ShakeListenerService$BackgroundThread$1;->this$1:Lcom/adobe/air/ShakeListenerService$BackgroundThread;

    iget-object v4, v4, Lcom/adobe/air/ShakeListenerService$BackgroundThread;->this$0:Lcom/adobe/air/ShakeListenerService;

    invoke-virtual {v4, v3}, Lcom/adobe/air/ShakeListenerService;->startActivity(Landroid/content/Intent;)V

    .line 114
    .end local v2    # "topActivity":Landroid/content/ComponentName;
    .end local v3    # "wandIntent":Landroid/content/Intent;
    :cond_0
    return-void
.end method
