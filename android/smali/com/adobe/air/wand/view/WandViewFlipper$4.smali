.class Lcom/adobe/air/wand/view/WandViewFlipper$4;
.super Ljava/lang/Object;
.source "WandViewFlipper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/wand/view/WandViewFlipper;->updateConnectionToken(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

.field final synthetic val$connectionToken:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/adobe/air/wand/view/WandViewFlipper;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/wand/view/WandViewFlipper;

    .prologue
    .line 274
    iput-object p1, p0, Lcom/adobe/air/wand/view/WandViewFlipper$4;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    iput-object p2, p0, Lcom/adobe/air/wand/view/WandViewFlipper$4;->val$connectionToken:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 277
    const-string v0, ""

    .line 278
    .local v0, "token":Ljava/lang/String;
    iget-object v3, p0, Lcom/adobe/air/wand/view/WandViewFlipper$4;->val$connectionToken:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    iget-object v3, p0, Lcom/adobe/air/wand/view/WandViewFlipper$4;->val$connectionToken:Ljava/lang/String;

    invoke-static {v3}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$300(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 280
    :cond_0
    iget-object v3, p0, Lcom/adobe/air/wand/view/WandViewFlipper$4;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v3}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$400(Lcom/adobe/air/wand/view/WandViewFlipper;)Landroid/view/View;

    move-result-object v3

    sget v4, Lcom/adobe/air/R$id;->token_string:I

    invoke-virtual {v3, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 281
    .local v2, "tokenView":Landroid/widget/TextView;
    invoke-virtual {v2, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 283
    iget-object v3, p0, Lcom/adobe/air/wand/view/WandViewFlipper$4;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v3}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$400(Lcom/adobe/air/wand/view/WandViewFlipper;)Landroid/view/View;

    move-result-object v3

    sget v4, Lcom/adobe/air/R$id;->token_desc:I

    invoke-virtual {v3, v4}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/TextView;

    .line 284
    .local v1, "tokenDesc":Landroid/widget/TextView;
    iget-object v3, p0, Lcom/adobe/air/wand/view/WandViewFlipper$4;->val$connectionToken:Ljava/lang/String;

    const-string v4, ""

    invoke-virtual {v3, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_1

    const/4 v3, 0x1

    :goto_0
    invoke-static {v3}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$500(Z)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 285
    return-void

    .line 284
    :cond_1
    const/4 v3, 0x0

    goto :goto_0
.end method
