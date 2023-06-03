.class Lcom/adobe/air/AndroidStageText$2;
.super Ljava/lang/Object;
.source "AndroidStageText.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/AndroidStageText;->refreshGlobalBounds(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/AndroidStageText;

.field final synthetic val$doCompleteDispatch:Z


# direct methods
.method constructor <init>(Lcom/adobe/air/AndroidStageText;Z)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/AndroidStageText;

    .prologue
    .line 851
    iput-object p1, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    iput-boolean p2, p0, Lcom/adobe/air/AndroidStageText$2;->val$doCompleteDispatch:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    .line 855
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$500(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    move-result-object v1

    if-nez v1, :cond_1

    .line 874
    :cond_0
    :goto_0
    return-void

    .line 860
    :cond_1
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$1600(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v1

    invoke-virtual {v1}, Landroid/graphics/Rect;->width()I

    move-result v1

    iget-object v2, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v2}, Lcom/adobe/air/AndroidStageText;->access$1600(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v2

    invoke-virtual {v2}, Landroid/graphics/Rect;->height()I

    move-result v2

    invoke-direct {v0, v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 861
    .local v0, "params":Landroid/widget/RelativeLayout$LayoutParams;
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$1600(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Rect;->left:I

    iput v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 862
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$1600(Lcom/adobe/air/AndroidStageText;)Landroid/graphics/Rect;

    move-result-object v1

    iget v1, v1, Landroid/graphics/Rect;->top:I

    iput v1, v0, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 864
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$500(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 868
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    invoke-static {v1}, Lcom/adobe/air/AndroidStageText;->access$500(Lcom/adobe/air/AndroidStageText;)Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/AndroidStageText$AndroidStageTextImpl;->requestLayout()V

    .line 870
    iget-boolean v1, p0, Lcom/adobe/air/AndroidStageText$2;->val$doCompleteDispatch:Z

    if-eqz v1, :cond_0

    .line 872
    iget-object v1, p0, Lcom/adobe/air/AndroidStageText$2;->this$0:Lcom/adobe/air/AndroidStageText;

    const/4 v2, 0x1

    invoke-static {v1, v2}, Lcom/adobe/air/AndroidStageText;->access$002(Lcom/adobe/air/AndroidStageText;Z)Z

    goto :goto_0
.end method
