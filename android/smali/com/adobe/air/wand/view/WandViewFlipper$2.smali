.class Lcom/adobe/air/wand/view/WandViewFlipper$2;
.super Ljava/lang/Object;
.source "WandViewFlipper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/wand/view/WandViewFlipper;->loadDefaultView()V
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
    .line 205
    iput-object p1, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    .prologue
    const/4 v4, 0x0

    .line 209
    iget-object v5, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v5}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$000(Lcom/adobe/air/wand/view/WandViewFlipper;)Landroid/view/View;

    move-result-object v5

    sget v6, Lcom/adobe/air/R$id;->skin:I

    invoke-virtual {v5, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/ImageView;

    .line 210
    .local v0, "skinView":Landroid/widget/ImageView;
    sget v5, Lcom/adobe/air/R$color;->transparent:I

    invoke-virtual {v0, v5}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 212
    iget-object v5, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v5, v4}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$102(Lcom/adobe/air/wand/view/WandViewFlipper;I)I

    .line 214
    const-string v1, ""

    .line 215
    .local v1, "token":Ljava/lang/String;
    iget-object v5, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v5}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$200(Lcom/adobe/air/wand/view/WandViewFlipper;)Lcom/adobe/air/wand/view/WandView$Listener;

    move-result-object v5

    if-eqz v5, :cond_0

    iget-object v5, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v5}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$200(Lcom/adobe/air/wand/view/WandViewFlipper;)Lcom/adobe/air/wand/view/WandView$Listener;

    move-result-object v5

    invoke-interface {v5}, Lcom/adobe/air/wand/view/WandView$Listener;->getConnectionToken()Ljava/lang/String;

    move-result-object v1

    .line 217
    :cond_0
    const-string v5, ""

    invoke-virtual {v1, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_1

    invoke-static {v1}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$300(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 219
    :cond_1
    iget-object v5, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v5}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$400(Lcom/adobe/air/wand/view/WandViewFlipper;)Landroid/view/View;

    move-result-object v5

    sget v6, Lcom/adobe/air/R$id;->token_string:I

    invoke-virtual {v5, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    .line 220
    .local v3, "tokenView":Landroid/widget/TextView;
    invoke-virtual {v3, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 222
    iget-object v5, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v5}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$400(Lcom/adobe/air/wand/view/WandViewFlipper;)Landroid/view/View;

    move-result-object v5

    sget v6, Lcom/adobe/air/R$id;->token_desc:I

    invoke-virtual {v5, v6}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/TextView;

    .line 223
    .local v2, "tokenDesc":Landroid/widget/TextView;
    iget-object v5, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v5}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$200(Lcom/adobe/air/wand/view/WandViewFlipper;)Lcom/adobe/air/wand/view/WandView$Listener;

    move-result-object v5

    invoke-interface {v5}, Lcom/adobe/air/wand/view/WandView$Listener;->getConnectionToken()Ljava/lang/String;

    move-result-object v5

    const-string v6, ""

    invoke-virtual {v5, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_2

    const/4 v4, 0x1

    :cond_2
    invoke-static {v4}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$500(Z)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v2, v4}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 225
    iget-object v4, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    iget-object v5, p0, Lcom/adobe/air/wand/view/WandViewFlipper$2;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    invoke-static {v5}, Lcom/adobe/air/wand/view/WandViewFlipper;->access$100(Lcom/adobe/air/wand/view/WandViewFlipper;)I

    move-result v5

    invoke-virtual {v4, v5}, Lcom/adobe/air/wand/view/WandViewFlipper;->setDisplayedChild(I)V

    .line 226
    return-void
.end method
