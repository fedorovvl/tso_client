.class Lcom/adobe/air/wand/view/WandViewFlipper$3;
.super Ljava/lang/Object;
.source "WandViewFlipper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/wand/view/WandViewFlipper;->loadCompanionView()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/wand/view/WandViewFlipper;


# direct methods
.method constructor <init>(Lcom/adobe/air/wand/view/WandViewFlipper;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/wand/view/WandViewFlipper;

    .prologue
    .line 237
    iput-object p1, p0, Lcom/adobe/air/wand/view/WandViewFlipper$3;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 241
    iget-object v0, p0, Lcom/adobe/air/wand/view/WandViewFlipper$3;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    iget-object v1, p0, Lcom/adobe/air/wand/view/WandViewFlipper$3;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v1}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$100(Lcom/adobe/air/wand/view/WandViewFlipper;)I

    move-result v1

    invoke-virtual {v0, v1}, Lcom/adobe/air/wand/view/WandViewFlipper;->setDisplayedChild(I)V

    .line 244
    :try_start_0
    iget-object v0, p0, Lcom/adobe/air/wand/view/WandViewFlipper$3;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v0}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$200(Lcom/adobe/air/wand/view/WandViewFlipper;)Lcom/adobe/air/wand/view/WandView$Listener;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/adobe/air/wand/view/WandViewFlipper$3;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v0}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$200(Lcom/adobe/air/wand/view/WandViewFlipper;)Lcom/adobe/air/wand/view/WandView$Listener;

    move-result-object v1

    iget-object v0, p0, Lcom/adobe/air/wand/view/WandViewFlipper$3;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-virtual {v0}, Lcom/adobe/air/wand/view/WandViewFlipper;->getContext()Landroid/content/Context;

    move-result-object v0

    check-cast v0, Landroid/app/Activity;

    invoke-virtual {v0}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    invoke-interface {v1, v0}, Lcom/adobe/air/wand/view/WandView$Listener;->onLoadCompanion(Landroid/content/res/Configuration;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 250
    :cond_0
    :goto_0
    return-void

    .line 246
    :catch_0
    move-exception v0

    goto :goto_0
.end method
