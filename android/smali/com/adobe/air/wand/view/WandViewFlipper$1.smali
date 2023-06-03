.class Lcom/adobe/air/wand/view/WandViewFlipper$1;
.super Ljava/lang/Object;
.source "WandViewFlipper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/adobe/air/wand/view/WandViewFlipper;->drawImage(Landroid/graphics/Bitmap;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

.field final synthetic val$scaledImage:Landroid/graphics/Bitmap;

.field final synthetic val$skinView:Landroid/widget/ImageView;


# direct methods
.method constructor <init>(Lcom/adobe/air/wand/view/WandViewFlipper;Landroid/widget/ImageView;Landroid/graphics/Bitmap;)V
    .locals 0
    .param p1, "this$0"    # Lcom/adobe/air/wand/view/WandViewFlipper;

    .prologue
    .line 180
    iput-object p1, p0, Lcom/adobe/air/wand/view/WandViewFlipper$1;->this$0:Lcom/adobe/air/wand/view/WandViewFlipper;

    iput-object p2, p0, Lcom/adobe/air/wand/view/WandViewFlipper$1;->val$skinView:Landroid/widget/ImageView;

    iput-object p3, p0, Lcom/adobe/air/wand/view/WandViewFlipper$1;->val$scaledImage:Landroid/graphics/Bitmap;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 185
    iget-object v0, p0, Lcom/adobe/air/wand/view/WandViewFlipper$1;->val$skinView:Landroid/widget/ImageView;

    iget-object v1, p0, Lcom/adobe/air/wand/view/WandViewFlipper$1;->val$scaledImage:Landroid/graphics/Bitmap;

    invoke-virtual {v0, v1}, Landroid/widget/ImageView;->setImageBitmap(Landroid/graphics/Bitmap;)V

    .line 186
    return-void
.end method
